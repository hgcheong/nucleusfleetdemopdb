import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/app.dart';

class InfoDialog {
  static Future show({
    required String title,
    String? body,
    Widget? content,
    String? closeText,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: body != null ? Text(body) : content,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  //   textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(closeText ?? "Close"),
            )
          ],
        );
      },
    );
  }
}

class ConfirmDialog {
  static Future delete({
    Widget? content,
    String title = "Delete ?",
    String body = "Are you sure you want to delete?",
    String cancelText = "Cancel",
    String confirmText = "Delete",
    bool destructive = true,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  //      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelText),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(confirmText),
            )
          ],
        );
      },
    );
  }

  static Future show({
    required String title,
    Widget? content,
    String? body,
    String? cancelText,
    String? confirmText,
    bool destructive = false,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: body != null ? Text(body) : content,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelText ?? "No"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(confirmText ?? "Yes"),
            )
          ],
        );
      },
    );
  }
}

class PromptModalNewPassword {
  static Future<List<String>?> show({
    required String title,
    required String? Function(String?) validator,
    required String labelText,
    bool obscureText = false,
    String? cancelText,
    String? confirmText,
    String initialValue = "",
    bool destructive = false,
    bool seconaryInput = false,
    String secondaryLabel = "",
    String secondaryInitialValue = "",
    bool secondaryObscureText = false,
    Function(String?)? secondaryValidator,
    String thirdLabel = "New Password",
    String thirdInitialValue = "",
    bool thirdObscureText = false,
    Function(String?)? thirdValidator,
    Function(List<String>)? onValidSubmission,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    final GlobalKey<FormState> formKey = GlobalKey();

    final TextEditingController controller =
        TextEditingController(text: initialValue);

    final TextEditingController secondaryController =
        TextEditingController(text: secondaryInitialValue);

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_rounded),
              sbh20,
              Text(
                title,
                style: const TextStyle(fontSize: 10),
              ),
              sbh10,
              const Text(
                '',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  autofocus: true,
                  decoration: InputDecoration(
                    label: Text(labelText),
                  ),
                  validator: validator,
                ),
                if (seconaryInput)
                  TextFormField(
                    controller: secondaryController,
                    obscureText: secondaryObscureText,
                    decoration: InputDecoration(
                      label: Text(secondaryLabel),
                    ),
                    validator: (String? value) {
                      if (secondaryValidator == null) return null;
                      return secondaryValidator(value);
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text(cancelText ?? "Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                final value = seconaryInput
                    ? [controller.value.text, secondaryController.value.text]
                    : [controller.value.text];

                if (onValidSubmission != null) {
                  onValidSubmission(value);
                  return;
                }

                Navigator.of(context).pop(value.isNotEmpty ? value : null);
              },
              child: Text(confirmText ?? "Submit"),
            )
          ],
        );
      },
    );
  }
}

class PromptModal {
  static Future<List<String>?> show({
    required String title,
    required String? Function(String?) validator,
    required String labelText,
    bool obscureText = false,
    String? cancelText,
    String? confirmText,
    String initialValue = "",
    bool destructive = false,
    bool seconaryInput = false,
    String secondaryLabel = "",
    String secondaryInitialValue = "",
    bool secondaryObscureText = false,
    Function(String?)? secondaryValidator,
    String thirdLabel = "New Password",
    String thirdInitialValue = "",
    bool thirdObscureText = false,
    Function(String?)? thirdValidator,
    Function(List<String>)? onValidSubmission,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    final GlobalKey<FormState> formKey = GlobalKey();

    final TextEditingController controller =
        TextEditingController(text: initialValue);

    final TextEditingController secondaryController =
        TextEditingController(text: secondaryInitialValue);

    final TextEditingController thirdController =
        TextEditingController(text: thirdInitialValue);

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_rounded),
              sbh20,
              Text(
                title,
                style: const TextStyle(fontSize: 10),
              ),
              sbh10,
              const Text(
                '',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  autofocus: true,
                  decoration: InputDecoration(
                    label: Text(labelText),
                  ),
                  validator: validator,
                ),
                TextFormField(
                  controller: thirdController,
                  obscureText: thirdObscureText,
                  decoration: InputDecoration(
                    label: Text(thirdLabel),
                  ),
                  validator: (String? value) {
                    if (thirdValidator == null) return null;
                    return thirdValidator(value);
                  },
                ),
                if (seconaryInput)
                  TextFormField(
                    controller: secondaryController,
                    obscureText: secondaryObscureText,
                    decoration: InputDecoration(
                      label: Text(secondaryLabel),
                    ),
                    validator: (String? value) {
                      if (secondaryValidator == null) return null;
                      return secondaryValidator(value);
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text(cancelText ?? "Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                final value = seconaryInput
                    ? [controller.value.text, secondaryController.value.text]
                    : [controller.value.text];

                if (onValidSubmission != null) {
                  onValidSubmission(value);
                  return;
                }

                Navigator.of(context).pop(value.isNotEmpty ? value : null);
              },
              child: Text(confirmText ?? "Submit"),
            )
          ],
        );
      },
    );
  }
}

class PromptModalForgetPassword {
  static Future<List<String>?> show({
    required String title,
    required String? Function(String?) validator,
    required String labelText,
    bool obscureText = false,
    String? cancelText,
    String? confirmText,
    String initialValue = "",
    bool destructive = false,
    bool seconaryInput = false,
    String secondaryLabel = "",
    String secondaryInitialValue = "",
    bool secondaryObscureText = false,
    Function(String?)? secondaryValidator,
    Function(String?)? thirdValidator,
    Function(List<String>)? onValidSubmission,
  }) async {
    final context = rootNavigatorKey.currentContext!;

    final GlobalKey<FormState> formKey = GlobalKey();

    final TextEditingController controller =
        TextEditingController(text: initialValue);

    final TextEditingController secondaryController =
        TextEditingController(text: secondaryInitialValue);

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_rounded),
              sbh20,
              Text(
                title,
                style: const TextStyle(fontSize: 10),
              ),
              sbh10,
              const Text(
                'To reset password please key in your registered email address',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  autofocus: true,
                  decoration: InputDecoration(
                    label: Text(labelText),
                  ),
                  validator: validator,
                ),
                if (seconaryInput)
                  TextFormField(
                    controller: secondaryController,
                    obscureText: secondaryObscureText,
                    decoration: InputDecoration(
                      label: Text(secondaryLabel),
                    ),
                    validator: (String? value) {
                      if (secondaryValidator == null) return null;
                      return secondaryValidator(value);
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: Text(cancelText ?? "Cancel"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: destructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                final value = seconaryInput
                    ? [controller.value.text, secondaryController.value.text]
                    : [controller.value.text];

                if (onValidSubmission != null) {
                  onValidSubmission(value);
                  return;
                }

                Navigator.of(context).pop(value.isNotEmpty ? value : null);
              },
              child: Text(confirmText ?? "Submit"),
            )
          ],
        );
      },
    );
  }
}
