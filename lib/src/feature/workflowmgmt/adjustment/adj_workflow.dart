import 'adj_models.dart';

/// State of one approval level for the current submission.
enum AdjLevelState { done, waiting, upcoming, returned, rejected }

/// One row of the Application Approval section.
class AdjLevelStatus {
  const AdjLevelStatus({
    required this.role,
    required this.approverEmail,
    required this.state,
    this.entry,
  });

  final AdjRole role;
  final String? approverEmail;
  final AdjLevelState state;

  /// Decision taken at this level in the current submission, if any.
  final AdjHistoryEntry? entry;
}

/// Approval rules. Change the flow here; screens and store read from it.
class AdjWorkflow {
  AdjWorkflow._();

  /// The role expected to act next, or null when the request is closed.
  static AdjRole? pendingRole(AdjRequest r) {
    switch (r.status) {
      case AdjStatus.rejected:
      case AdjStatus.completed:
        return null;
      case AdjStatus.returned:
        return AdjRole.requestor;
      case AdjStatus.inProgress:
        return switch (r.stage) {
          AdjStage.submitted => AdjRole.businessReviewer,
          AdjStage.businessReviewed => AdjRole.aaApprover,
          AdjStage.aaApproved => AdjRole.financeReviewer,
          AdjStage.financeReviewed => AdjRole.financeApprover,
          AdjStage.financeApproved => AdjRole.financeOps,
          AdjStage.completed => null,
        };
    }
  }

  /// Only the person assigned to the pending level can act; the requestor
  /// acts only when it's returned; nobody approves their own request.
  static bool canAct(AdjRequest r, AdjUser user) {
    final role = pendingRole(r);
    if (role == null) return false;
    if (role == AdjRole.requestor) return user.email == r.requestorEmail;
    if (user.email == r.requestorEmail) return false;
    return user.role == role && r.approvers[role] == user.email;
  }

  /// Files can be added by whoever the request is with.
  static bool canAttach(AdjRequest r, AdjUser user) => canAct(r, user);

  /// You can remove only files you added, and only while it's your turn.
  static bool canRemoveDocument(AdjRequest r, AdjUser user, AdjDocument d) =>
      canAct(r, user) && d.uploadedBy == user.email;

  /// Step that new files are filed under now (null when closed).
  static AdjRole? currentFileStep(AdjRequest r) => pendingRole(r);

  /// Stepper position (0 = Submitted) for a file step, and back.
  static AdjRole fileStepAt(int index) =>
      index == 0 ? AdjRole.requestor : AdjRole.levels[index - 1];

  /// Checks a proposed approval route. Returns a message, or null if valid.
  static String? routeProblem(String requestorEmail, Map<AdjRole, String?> approvers) {
    for (final role in AdjRole.levels) {
      final email = approvers[role];
      if (email == null || email.isEmpty) return 'Choose a ${role.label.toLowerCase()}.';
      if (email == requestorEmail) return "You can't be an approver on your own request.";
    }
    return null;
  }

  /// Status of every approval level for the current submission.
  /// A resubmission starts a new cycle, so earlier decisions are cleared.
  static List<AdjLevelStatus> levels(AdjRequest r, AdjRole? Function(String email) roleOf) {
    var start = 0;
    for (var i = 0; i < r.history.length; i++) {
      final a = r.history[i].action;
      if (a == AdjAction.submitted || a == AdjAction.resubmitted) start = i + 1;
    }
    final cycle = r.history.sublist(start);
    final pending = pendingRole(r);

    return [
      for (final role in AdjRole.levels)
        _level(r, role, cycle, pending, roleOf),
    ];
  }

  static AdjLevelStatus _level(
    AdjRequest r,
    AdjRole role,
    List<AdjHistoryEntry> cycle,
    AdjRole? pending,
    AdjRole? Function(String email) roleOf,
  ) {
    AdjHistoryEntry? entry;
    for (final e in cycle) {
      if (!e.action.isDocumentChange && roleOf(e.actorEmail) == role) entry = e;
    }
    final state = entry == null
        ? (pending == role ? AdjLevelState.waiting : AdjLevelState.upcoming)
        : switch (entry.action) {
            AdjAction.returned => AdjLevelState.returned,
            AdjAction.rejected => AdjLevelState.rejected,
            _ => AdjLevelState.done,
          };
    return AdjLevelStatus(
      role: role,
      approverEmail: r.approvers[role],
      state: state,
      entry: entry,
    );
  }

  /// Button label for moving the request on from [stage].
  static String approveLabel(AdjStage stage, [AdjKind kind = AdjKind.adjustment]) => switch (stage) {
        AdjStage.submitted || AdjStage.aaApproved => 'Mark as reviewed',
        AdjStage.businessReviewed || AdjStage.financeReviewed => 'Approve',
        AdjStage.financeApproved => switch (kind) {
            AdjKind.bulkPayment => 'Release payment',
            AdjKind.bankGuarantee || AdjKind.creditAdjustment => 'Apply new credit limit',
            AdjKind.lpc => 'Post LPC charge',
            AdjKind.dataEntry => 'Mark as approved',
            AdjKind.adjustment => 'Mark as completed',
          },
        AdjStage.completed => 'Completed',
      };

  /// History action recorded when the request moves on from [stage].
  static AdjAction approveAction(AdjStage stage) => switch (stage) {
        AdjStage.submitted || AdjStage.aaApproved => AdjAction.reviewed,
        AdjStage.businessReviewed || AdjStage.financeReviewed => AdjAction.approved,
        AdjStage.financeApproved || AdjStage.completed => AdjAction.completed,
      };

  static String pendingDescription(AdjRequest r) {

    switch (r.status) {
      case AdjStatus.rejected:
        return 'Rejected. No further action is possible.';
      case AdjStatus.completed:
        return switch (r.kind) {
          AdjKind.bulkPayment => 'Payment released.',
          AdjKind.bankGuarantee || AdjKind.creditAdjustment => 'New credit limit applied.',
          AdjKind.lpc => 'LPC charge posted.',
          AdjKind.dataEntry => 'Transaction approved.',
          AdjKind.adjustment => 'Adjustment completed.',
        };
      case AdjStatus.returned:
        return 'Returned to the requestor for amendment.';
      case AdjStatus.inProgress:
        final role = pendingRole(r)!;
        final verb = switch (r.stage) {
          AdjStage.submitted || AdjStage.aaApproved => 'review',
          AdjStage.financeApproved => switch (r.kind) {
              AdjKind.bulkPayment => 'release the payment',
              AdjKind.bankGuarantee || AdjKind.creditAdjustment => 'apply the new credit limit',
              AdjKind.lpc => 'post the LPC charge',
              AdjKind.dataEntry => 'give final approval',
              AdjKind.adjustment => 'post the adjustment',
            },
          _ => 'approve',
        };
        return 'Waiting for ${role.label} to $verb.';
    }
  }
}
