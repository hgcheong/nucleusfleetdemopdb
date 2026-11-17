# Task Approval

Self-contained approval workflow with six sample task types. It needs no
API, stored procedure or server setup: demo users, requests and registers are
built in, and changes are kept in this browser (shared_preferences /
localStorage).

Open **Task Approval** in the side menu (`/workflowmgmt/adjustment`). The
module sidebar switches between the queues:

| Queue | Path | What is approved |
|---|---|---|
| Adjustment Approval | `/workflowmgmt/adjustment` | Account adjustments |
| Bulk Payment Approval | `/workflowmgmt/bulkpayment` | One payment run to many payees |
| Bank Guarantee Expiry | `/workflowmgmt/bankguarantee` | Lowering a customer's credit limit when the bank guarantee securing it expires |
| LPC Charges | `/workflowmgmt/lpc` | Late payment charge on a statement with no payment received |
| Data Entry Approval | `/workflowmgmt/dataentry` | Transactions sent from Data Entry with **Request for approval** |
| Credit Adjustment | `/workflowmgmt/creditadj` | Increasing (permanently or temporarily) or decreasing a customer's credit limit, with a credit evaluation |

## Flow (all task types)

Submitted → Business Review → Approving Authority → Finance Review →
Finance Approver → Finance Processor (completed).

- Only the person assigned to the current level can act. Nobody can approve
  their own request.
- Approvers can approve, return to the requestor (remarks required) or reject
  (remarks required). A returned request is amended and resubmitted, and
  starts again at Business Review. Rejecting an LPC task waives the charge.
- Every step can have its own files. You can remove only files you added,
  while it's your turn.
- Every decision and file change is in the Activity Log.

The last step's button and outcome depend on the type: **Mark as completed**
(adjustment), **Release payment** (bulk payment), **Apply new credit limit**
(bank guarantee: updates the credit limit in the guarantee register),
**Post LPC charge** (LPC: marks the statement as charged), **Mark as
approved** (Data Entry), **Apply new credit limit** (credit adjustment:
updates the customer credit register).

## Task types in more detail

**Bulk payment.** Payee lines (payee, bank, account, amount, reference), a
debit account and a payment date. The total is the sum of the lines. Lines can
be typed in or imported from CSV (`payee,bank,account,amount,reference`;
**Download template** gives a sample). The request page shows the lines with a
total and can export them as CSV. Up to 500 payees.

**Bank guarantee expiry.** The queue lists guarantees expiring within 30 days
(and ones already expired) that haven't been dealt with, each with **Create
approval task**. The task suggests the new credit limit (current limit minus
the guarantee amount) and an effective date (the expiry date); both can be
changed. One open task per guarantee.

**LPC charges.** The queue lists statements past their due date with no
payment received, each with **Create approval task**. Charge =
outstanding × rate × days overdue ÷ 365 (default rate 18% a year, editable
from 0 to 36%). Partly paid statements are listed but not offered for LPC.
One open task per statement.

**Data Entry approval.** Every Data Entry transaction screen (Adjustment,
Payment, Sale, Fee, Pukal, manual transaction) has a **Request for approval**
button in its action column, next to Save, Back to list and Audit log. It
needs a saved transaction, copies the form fields into the task, and asks
for a reason and the approvers. While the task is open, the button opens it.
The task page has **Open transaction** to go back to the Data Entry screen.
One open task per transaction. To add the button to another screen, see the
example at the top of `widgets/adj_request_approval_btn.dart`.

**Adjustment.** Eleven adjustment types: Credit / Debit Misc Transfer Adjust,
Reload Reversal, Duplicate Transaction Reversal, Fuel Price Correction, Rebate
Adjustment, Card Balance Transfer, Fee Waiver, LPC Reversal, Chargeback
Adjustment and Small Balance Write-off. **Fill with sample** on the New request
form fills the amount, account and reason with made-up values for the chosen
type (press again for different values).

## Random sample data

Reference codes of all sample tasks, and the sample adjustments' type, amount,
account and reason, are random (`adj_samples.dart`). They are made when the
demo data is first built and kept in the browser after that; **Reset demo
data** makes a new set. Codes keep the usual format: prefix + yyMMddHHmm + 6
digits.

**Credit adjustment.** Three types: permanent increase, temporary increase
(with an end date, up to 180 days) and permanent decrease. The queue lists
the customer credit register (limit, balance, % used) with **Request credit
adjustment** per customer. The request can also be raised from **Customer
Management**: the postpaid account settings screen has a **Request credit
adjustment** button in its action column (`AdjCreditRequestBtn`), which opens
the form with the account, customer and current limit filled in; the task
page then has **Open customer account** to go back. One open credit
adjustment per account.

Every credit adjustment includes a **credit evaluation**. The figures load
from the register when the account is in it (otherwise they are typed in),
the form shows the result live, and approvers see it on the task page. Sample
scoring, out of 100:

| Factor | Points |
|---|---|
| Late payments in 12 months | 0: 30, 1-2: 20, 3-5: 10, more: 0 |
| Worst days past due | 0: 20, up to 30: 12, up to 60: 5, more: 0 |
| Relationship | 3 years+: 15, 1 year+: 10, 6 months+: 5, less: 0 |
| Balance against requested limit | up to 50%: 15, 80%: 10, 100%: 5, more: 0 |
| Security held against requested limit | 50%+: 20, 25%+: 12, any: 6, none: 0 |

Grade A 80+ (low risk), B 65+, C 50+, D below 50 (high risk). Recommended
limit = average monthly spend × 2.0 / 1.5 / 1.0 / 0.5 for A / B / C / D, plus
security held, rounded down to RM 1,000. A requested limit above it is flagged
"Above recommendation" but can still be submitted. The scoring lives in
`AdjCreditEval` (`adj_models.dart`); change it to your credit policy there.

Samples: a grade A permanent increase waiting for the Approving Authority, a
grade D temporary increase above the recommendation waiting for Business
Review, and a completed decrease.

Use **Acting as** (top right of each page) to switch between the demo users
and walk a task through every step. **Reset demo data** in the same menu puts
the starting data back.

## Files

| File | What it holds |
|---|---|
| `adj_models.dart` | Task kinds, stages, roles, request, payment line, guarantee, overdue statement, documents, history |
| `adj_workflow.dart` | Approval rules: who acts when, button labels, level status |
| `adj_seed.dart` | Demo users, default route, sample tasks, guarantee register, overdue statements, dropdown lists |
| `adj_store.dart` | Riverpod store (`adjStoreProvider`): all actions, validation, outcomes, browser storage |
| `adj_samples.dart` | Random reference codes, adjustment amounts, accounts and reason text |
| `adj_csv.dart` | Payment line CSV import and export |
| `adj_files.dart` | File picking, preview and download in the browser |
| `adj_nav.dart` | Paths for the pages |
| `screens/` | Queue, request detail, new request (`BaseScreen` pages, shared by all kinds) |
| `widgets/` | Stepper, step details, documents, approval levels, decision panel, history, payment lines, registers, credit evaluation view, Data Entry and Customer Management buttons |

Input boxes use `AdjField` (in `widgets/adj_common.dart`), which wraps the
app's `FbField` so they have the same DiBold height, spacing and label style
as the Fb* form fields.

Page ids (for `isPageDeniedView` and the access-control list): 9300 container,
9301 queue, 9302 detail, 9303 new request; main menu 9310; breadcrumb
9311–9312; module sidebar 9313–9318. None are in the server list yet, so the
module shows for everyone until you add them.

## Storage limits

Browser storage is about 5 MB per site and is shared with the rest of the app.
File content is kept after a reload only for files up to 512 KB, and up to
2 MB in total. Larger files work normally until the page reloads.

The storage key is versioned (`smartpay_adj_workflow_v5`); data saved by an
older version is ignored so new samples appear.

## Moving to real data later

The screens only call `adjStoreProvider`. To connect your backend:

1. Replace `adjDemoUsers` / `currentUser` with the signed-in session.
2. Load requests, the guarantee register and overdue statements from your
   APIs instead of `adjSeed*()`.
3. Replace the bodies of `approve`, `returnForAmendment`, `reject`,
   `resubmit`, `addDocuments`, `removeDocument` and `submit`, and do the work
   in `_applyOutcome` (credit limit change, LPC posting) on the server.
4. Enforce the same rules on the server.

## Routes

The pages are registered in `workflowmgmtTabRouter` (`core/app_router.dart`)
as `:kind`, `:kind/new` and `:kind/view/:refcode`. Their entries were added
to `app_router.gr.dart` in the generator's format; running
`dart run build_runner build` regenerates the same entries.

## Record cards (NavWrap widgets)

`AcxListButtonNavWrap`, `…WrapExt`, `…WrapManual`, `…WrapManualDirector` and
`…WrapSelect` (in `lib/src/core/components`) now draw their records with the
shared `AcxNavTile` (`acx_nav_tile.dart`) in the Task Approval stat-card
design: DiBold card, theme colours only so it matches light and dark mode, a
tinted badge with the record's initials, bold first line, muted details, a
chevron that turns into a check when selected, a tinted background with a
2 px teal border when selected, hover highlight, Delete and Edit in a footer, an
"Add new" card and a "No records yet" state. Their constructors are
unchanged, so existing screens need no edits.
