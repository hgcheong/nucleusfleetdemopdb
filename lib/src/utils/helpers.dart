import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/app/api_acxlangkeyval.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/components/alert_dialogs.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uihelpers.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Returndata> loadDataQueryObject(WidgetRef ref, QueryObject query) async {
  try {
    // isloading.value = true;
    final resData = await ref
        .read(repoQueryProvider)
        .retrieveData(query.querysql, query.params)
        .onError((error, stackTrace) {
      // showAlertDialog(context: context, title: 'Error Loading', content: 'Failed');
      return Returndata();
    });

    return resData;
  } catch (e) {
    Toast.error(e.toString());
    return Returndata();
  } finally {
    //  isloading.value = false;
  }
}

Future<Returndata> loadData(WidgetRef ref, String querysql,
    Map<String, dynamic> params, ValueNotifier<bool> isloading) async {
  try {
    // isloading.value = true;
    final resData = await ref
        .read(repoQueryProvider)
        .retrieveData(querysql, params)
        .onError((error, stackTrace) {
      // showAlertDialog(context: context, title: 'Error Loading', content: 'Failed');
      Toast.error(error.toString());
      return Returndata();
    });

    return resData;
  } catch (e) {
    Toast.error(e.toString());
    return Returndata();
  } finally {
    //  isloading.value = false;
  }
}

Future<List<Langkeypair>> loadColumnName(
  BuildContext context,
  WidgetRef ref,
  String querysql,
  Map<String, dynamic> params,
) async {
  try {
    return await ref
        .read(repoLangKeyValueProvider)
        .retrieveLangKey(querysql, params)
        .onError((error, stackTrace) {
      if (context.mounted) {
        showAlertDialog(
            context: context, title: 'Error Loading', content: 'Failed');
      }

      return [];
    });
  } catch (e) {
    showAlertDialog(
        context: context, title: 'Error Loading', content: e.toString());
    return [];
  } finally {}
}

Future<dynamic> showAcxAlertDialog(BuildContext context, Widget child) {
  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: AlertDialog(content: child),
        );
      });
}

//The Below is needed when we want to show a snackbar inside of the Dialog Box
Future<dynamic> showAcxSimpleDialog(BuildContext context, Widget child) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: SimpleDialog(children: [child]),
        );
      });
}

//The Below is needed when we want to show a snackbar inside of the Dialog Box
Future<dynamic> showAcxDialog(BuildContext context, Widget child) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Dialog(child: child),
        );
      });
}

// //The Below is needed when we want to show a snackbar inside of the Dialog Box
// Future<dynamic> showAcxAlertDialog(BuildContext context, Widget child) async {
//  return showDialog(
//   barrierDismissible: false,
//     context: context,
//     builder: (context) => ScaffoldMessenger(
//       child: Builder(
//         builder: (context) => Scaffold(
//           body: AlertDialog(content: child),
//         ),
//       ),
//     ),
//   );
// }

Future downloadReport(
    BuildContext context, String url, String id, QueryObject query, String logId) async {
  try {
    await ApiService().postDownload(
      '/s3/download?logId=${convStrNewOrNullToNull(logId)}',
      params: {'key': id},
    );
    Toast.message('Downloaded');
  } catch (ex) {
    Toast.error(ex.toString());
  } finally {}
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}
