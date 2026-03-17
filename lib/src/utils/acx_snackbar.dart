import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

SnackBar acxSnackBar(Returndata returndata) {
  return SnackBar(
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
}
