import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_savebuttonmanual.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_dtp.dart';

class PukalProcessDateDialog extends ConsumerWidget {
  const PukalProcessDateDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pukalPrcsDateKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: pukalPrcsDateKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: SelectableText(
              'Please Choose Pukal Process Date',
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                    flex: 11,
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListView(
                              children: const [
                                ListTile(
                                    title: FbDateTimePicker(
                                        name: 'PrcsDate',
                                        label: 'Process Date')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      AcxSaveButtonManual(onSave: () {
                        
                        pukalPrcsDateKey.currentState!.save();
                        singleton<AppRouter>()
                            .maybePop(pukalPrcsDateKey.currentState!.value);
                      }),
                      sbh10,
                      ElevatedButton(
                          onPressed: () {
                            singleton<AppRouter>().maybePop();
                          },
                          child: const Icon(Icons.exit_to_app))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
