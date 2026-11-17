import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:web/web.dart' as web;

import 'adj_models.dart';
import 'adj_store.dart';

const adjFileRulesText = 'PDF, Excel, Word, CSV or images, up to 10 MB each.';

/// Opens the browser file picker. Returns files that pass the checks
/// (type, size, not already attached); the rest are listed in a toast.
/// Step and uploader are set by the store when the files are added.
Future<List<AdjDocument>> adjPickFiles({Iterable<String> existingNames = const []}) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    withData: true,
    type: FileType.custom,
    allowedExtensions: AdjStore.allowedExtensions,
  );
  if (result == null) return [];

  final names = {for (final n in existingNames) n.toLowerCase()};
  final accepted = <AdjDocument>[];
  final rejected = <String>[];
  var i = 0;
  for (final f in result.files) {
    final ext = f.name.contains('.') ? f.name.split('.').last.toLowerCase() : '';
    if (!AdjStore.allowedExtensions.contains(ext)) {
      rejected.add('${f.name} (file type not allowed)');
    } else if (f.size > AdjStore.maxFileBytes) {
      rejected.add('${f.name} (larger than 10 MB)');
    } else if (f.bytes == null) {
      rejected.add('${f.name} (could not be read)');
    } else if (!names.add(f.name.toLowerCase())) {
      rejected.add('${f.name} (already attached)');
    } else {
      accepted.add(AdjDocument(
        id: 'picked-${i++}',
        fileName: f.name,
        sizeBytes: f.size,
        step: AdjRole.requestor,
        bytes: f.bytes,
      ));
    }
  }
  if (rejected.isNotEmpty) Toast.error('Not attached: ${rejected.join('; ')}.');
  return accepted;
}

/// Opens a PDF or image in a new tab; other types are downloaded.
/// Returns a message when nothing could be shown.
String? adjPreview(AdjDocument d) {
  final missing = _missingContent(d);
  if (missing != null) return missing;
  if (!d.previewable) {
    _download(d.bytes!, d.fileName, d.mimeType);
    return "${d.extension.toUpperCase()} files can't open in the browser, so it was downloaded instead.";
  }
  final url = _objectUrl(d.bytes!, d.mimeType);
  web.window.open(url, '_blank');
  Timer(const Duration(minutes: 2), () => web.URL.revokeObjectURL(url));
  return null;
}

/// Saves the file. Returns a message when there's nothing to save.
String? adjDownload(AdjDocument d) {
  final missing = _missingContent(d);
  if (missing != null) return missing;
  _download(d.bytes!, d.fileName, d.mimeType);
  return null;
}

/// Saves text the app generated (CSV export, template) as a file.
void adjSaveText(String fileName, String text, {String mimeType = 'text/csv'}) =>
    _download(Uint8List.fromList(utf8.encode(text)), fileName, mimeType);

/// Lets the user choose one CSV file and returns its text, or null if they
/// cancelled or it couldn't be read (a toast explains why).
Future<String?> adjPickCsvText() async {
  final result = await FilePicker.platform.pickFiles(
    withData: true,
    type: FileType.custom,
    allowedExtensions: const ['csv'],
  );
  final file = result == null || result.files.isEmpty ? null : result.files.first;
  if (file == null) return null;
  if (file.bytes == null) {
    Toast.error('${file.name} could not be read.');
    return null;
  }
  if (file.size > 2 * 1024 * 1024) {
    Toast.error('${file.name} is larger than 2 MB. Split it into smaller files.');
    return null;
  }
  return utf8.decode(file.bytes!, allowMalformed: true);
}

String? _missingContent(AdjDocument d) {
  if (d.hasContent) return null;
  if (d.isSample) {
    return 'This is a sample entry with no file behind it. Attach your own files to try preview and download.';
  }
  return 'This file was too large to keep in the browser after the page reloaded. '
      'Only files up to 512 KB are kept.';
}

String _objectUrl(Uint8List bytes, String mimeType) {
  final blob = web.Blob(<JSAny>[bytes.toJS].toJS, web.BlobPropertyBag(type: mimeType));
  return web.URL.createObjectURL(blob);
}

void _download(Uint8List bytes, String fileName, String mimeType) {
  final url = _objectUrl(bytes, mimeType);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName;
  anchor.click();
  Timer(const Duration(seconds: 30), () => web.URL.revokeObjectURL(url));
}
