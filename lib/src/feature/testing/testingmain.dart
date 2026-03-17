import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=203;

@RoutePage()
class TestingMain extends StatelessWidget {
  const TestingMain({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final testKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> curVale = {"row": null, "column": null};
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const SelectableText('Testing'),
      ),
      body: SizedBox(
          height: 1280,
          child: Column(
            children: [
              FormBuilder(
                initialValue: curVale,
                key: testKey,
                child: Row(
                  children: [
                    const Expanded(child: FbText(name: 'row', label:'row')),
                    const Expanded(child: FbText(name: 'column', label:'column')),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            testKey.currentState!.save();
                            Toast.message(
                                testKey.currentState!.value.toString());
                            singleton<AppRouter>().navigate(RowandColumn(
                                row: int.parse(
                                    testKey.currentState!.value['row']),
                                column: int.parse(
                                    testKey.currentState!.value['column'])));
                          },
                          child: const SelectableText('Test')),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            testKey.currentState!.save();
                            Toast.message(
                                testKey.currentState!.value.toString());
                            singleton<AppRouter>().navigate(RowandColumn2(
                                row: int.parse(
                                    testKey.currentState!.value['row']),
                                column: int.parse(
                                    testKey.currentState!.value['column'])));
                          },
                          child: const SelectableText('Test')),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 400, child: AutoRouter())
            ],
          )),
    );
  }
}
