import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/feature/theme/dibold_theme.dart';
import 'package:nucleusv2/src/utils/toast.dart';

import '../adj_files.dart';
import '../adj_models.dart';
import '../adj_store.dart';
import '../adj_workflow.dart';
import 'adj_common.dart';

/// Files on a request. With [onlyStep] null, every file is shown under the
/// step it was added at; otherwise only that step's files. New files always
/// go to the step the request is at, so the attach button shows only where
/// that step is shown.
class AdjDocuments extends ConsumerWidget {
  const AdjDocuments({super.key, required this.referenceCode, this.onlyStep});

  final String referenceCode;
  final AdjRole? onlyStep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final store = ref.watch(adjStoreProvider);
    final r = store.find(referenceCode);
    if (r == null) return const SizedBox.shrink();
    final me = store.currentUser;
    final current = AdjWorkflow.currentFileStep(r);
    final canAttachHere =
        AdjWorkflow.canAttach(r, me) && current != null && (onlyStep == null || onlyStep == current);
    final currentTitle = current?.levelTitle ?? '';

    final docs = onlyStep == null ? r.documents : r.documents.where((d) => d.step == onlyStep).toList();
    final groups = <(AdjRole, List<AdjDocument>)>[
      for (final step in [AdjRole.requestor, ...AdjRole.levels])
        (step, docs.where((d) => d.step == step).toList()),
    ].where((g) => g.$2.isNotEmpty).toList();

    Widget box(List<AdjDocument> list) => _DashedBox(
          color: cs.primary,
          child: Column(children: [
            for (var i = 0; i < list.length; i++)
              _DocRow(
                doc: list[i],
                uploader: store.nameOf(list[i].uploadedBy),
                divider: i < list.length - 1,
                onRemove: AdjWorkflow.canRemoveDocument(r, me, list[i])
                    ? () => _remove(context, ref, list[i])
                    : null,
              ),
          ]),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (docs.isEmpty)
          _DashedBox(
            color: cs.outline,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Column(children: [
                Icon(Icons.upload_file, size: 26, color: cs.onSurfaceVariant),
                const SizedBox(height: 6),
                Text(onlyStep == null ? 'No documents attached' : 'No files were added at this step.',
                    textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant)),
              ]),
            ),
          )
        else if (onlyStep != null)
          box(docs)
        else
          for (var g = 0; g < groups.length; g++) ...[
            if (g > 0) const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Text(groups[g].$1.levelTitle, style: TextStyle(fontWeight: FontWeight.w700, color: cs.onSurface)),
                const SizedBox(width: 8),
                Text('${groups[g].$2.length} ${groups[g].$2.length == 1 ? 'file' : 'files'}',
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
              ]),
            ),
            box(groups[g].$2),
          ],
        if (canAttachHere || (onlyStep == null && docs.length > 1)) ...[
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: DiboldTheme.actionSpacing,
            runSpacing: 8,
            children: [
              if (canAttachHere)
                FilledButton.icon(
                  onPressed: () => _attach(ref, r),
                  icon: const Icon(Icons.attach_file, size: 18),
                  label: Text(onlyStep == null ? 'Attach to $currentTitle' : 'Attach files'),
                ),
              if (onlyStep == null && docs.length > 1)
                OutlinedButton.icon(
                  onPressed: () => _downloadAll(docs),
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download all files'),
                ),
            ],
          ),
        ],
        if (canAttachHere) ...[
          const SizedBox(height: 8),
          Text(
            'Files you add now are filed under $currentTitle. $adjFileRulesText',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
        ],
      ],
    );
  }

  Future<void> _attach(WidgetRef ref, AdjRequest r) async {
    // The store lives for the whole app, so it's safe to use after picking;
    // it re-checks that the request is still with this user.
    final store = ref.read(adjStoreProvider.notifier);
    final picked = await adjPickFiles(existingNames: r.documents.map((d) => d.fileName));
    if (picked.isEmpty) return;
    adjRun(
      () => store.addDocuments(r.referenceCode, picked),
      success: picked.length == 1 ? '${picked.first.fileName} attached' : '${picked.length} files attached',
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, AdjDocument doc) async {
    final store = ref.read(adjStoreProvider.notifier);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove file?'),
        content: Text('${doc.fileName} will be removed from this request. '
            'The removal is recorded in the activity log.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: context.dbStatus.danger),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    adjRun(() => store.removeDocument(referenceCode, doc.id),
        success: '${doc.fileName} removed');
  }

  void _downloadAll(List<AdjDocument> docs) {
    final withContent = docs.where((d) => d.hasContent).toList();
    for (final d in withContent) {
      adjDownload(d);
    }
    if (withContent.isEmpty) {
      Toast.error('None of these files can be downloaded: they are sample entries or too large to keep.');
    } else if (withContent.length < docs.length) {
      Toast.message('Downloaded ${withContent.length} of ${docs.length} files. '
          'The rest are sample entries or were too large to keep after a reload.');
    }
  }
}

class _DocRow extends StatelessWidget {
  const _DocRow({required this.doc, required this.uploader, required this.divider, this.onRemove});

  final AdjDocument doc;
  final String uploader;
  final bool divider;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final narrow = MediaQuery.sizeOf(context).width < 760;
    final added = doc.uploadedAt == null ? 'Added by $uploader' : 'Added by $uploader on ${adjDate(doc.uploadedAt!)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: divider ? Border(bottom: BorderSide(color: cs.outlineVariant)) : null,
      ),
      child: Row(
        children: [
          Icon(Icons.description, size: 20, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.fileName, style: TextStyle(color: cs.onSurface)),
                Text(narrow ? '${adjSize(doc.sizeBytes)} · $added' : added,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          if (!narrow)
            Expanded(
              flex: 1,
              child: Text(adjSize(doc.sizeBytes), style: TextStyle(color: cs.onSurface)),
            ),
          IconButton.outlined(
            tooltip: 'Preview',
            icon: Icon(Icons.search, color: cs.primary, size: 20),
            onPressed: () {
              final msg = adjPreview(doc);
              if (msg != null) Toast.message(msg);
            },
          ),
          const SizedBox(width: 6),
          OutlinedButton(
            onPressed: () {
              final msg = adjDownload(doc);
              if (msg != null) Toast.message(msg);
            },
            child: const Text('Download'),
          ),
          if (onRemove != null)
            IconButton(
              tooltip: 'Remove file',
              color: context.dbStatus.danger,
              icon: const Icon(Icons.delete_outline),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}

class _DashedBox extends StatelessWidget {
  const _DashedBox({required this.child, required this.color});
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _DashedPainter(color),
        child: Padding(padding: const EdgeInsets.all(3), child: child),
      );
}

class _DashedPainter extends CustomPainter {
  _DashedPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(DiboldTheme.radiusSm)));
    for (final m in path.computeMetrics()) {
      for (var d = 0.0; d < m.length; d += 7) {
        canvas.drawPath(m.extractPath(d, d + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) => old.color != color;
}
