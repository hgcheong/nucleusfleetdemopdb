import 'package:flutter/material.dart';
import 'package:nucleusv2/src/app.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/theme/app_theme.dart';

class Toast {
  static dynamic showresult(Returndata returndata) {
    if (returndata.message!.msgSeverity == 0) {
      return success(returndata.message!.dscp.toString());
    }
    return error(
        '[${returndata.message!.msgId.toString()}] ${returndata.message!.dscp.toString()}');
  }

  static void newMessageDialog(BuildContext context, String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            child: SelectableText(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void newMessage(BuildContext context, Returndata returndata) {
    final snackBar = SnackBar(
      backgroundColor:
          returndata.message!.msgSeverity == 0 ? Colors.blue : Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            child: SelectableText(
              returndata.message!.dscp.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showTopDialog(BuildContext context, Returndata returndata) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
          returndata.message!.msgSeverity == 0 ? Colors.blue : Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            child: SelectableText(
              returndata.message!.dscp.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }

  static void message(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error_outline),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            child: SelectableText(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void error([String message = "Page Reloaded"]) {
    //  final context = rootNavigatorKey.currentContext!;

    final snackBar = SnackBar(
        showCloseIcon: true,
        //    duration: const Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.error_outline),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              child: SelectableText(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        //  backgroundColor: Theme.of(context).colorScheme.info
        backgroundColor: Colors.red);
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void success([String message = "Success"]) {
    final context = rootNavigatorKey.currentContext!;

    final snackBar = SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.check_circle_outline),
          const SizedBox(
            width: 30,
          ),
          SelectableText(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.success,
    );
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
