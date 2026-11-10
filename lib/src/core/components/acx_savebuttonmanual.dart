import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';

class AcxSaveButtonManual extends HookConsumerWidget {
  const AcxSaveButtonManual({
    super.key,
    required this.onSave,
    this.iconData = Icons.save,
    this.message = 'Save',
    this.confirmSave = false,
  });

  final Function onSave;
  final bool confirmSave;
  final IconData? iconData;
  final String message;
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      AcxActionSpacing(child: _buildButton(context, ref));

  Widget _buildButton(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    if (context.mounted) {
      return isLoading.value == true
          ? ElevatedButton(
              child: const SizedBox(
                width: 30,
                child: LinearProgressIndicator(
                  color: Colors.white,
                ),
              ),
              onPressed: () {})
          : Tooltip(
            message:message,
            child: ElevatedButton(
                child:  SizedBox(
                  width: 30,
                  child: Icon(
                    // color: Color.fromARGB(255, 192, 205, 215),
                   iconData
                  ),
                ),
                onPressed: () async {
                  try {
                    //  isLoading.value = true;
                    if (confirmSave) {
                      bool? confirmed = await ConfirmDialog.show(
                        title: "Delete?",
                        body: "Are you sure you want to Delete?",
                        destructive: true,
                        confirmText: "Yes",
                        cancelText: "Cancel",
                      );
                      if (confirmed != null) {
                        if (!confirmed) {
                          return;
                        }
                      }
                    }
            
                    onSave();
                  } catch (e) {
                    Toast.error(e.toString());
                  } finally {
                    //     isLoading.value = false;
                  }
                },
              ),
          );
    } else {
      return Container();
    }
  }
}
