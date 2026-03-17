import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_vw_txn_plan_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/helpers.dart';
import 'package:nucleusv2/src/utils/strings.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class AcxTxnPlanList extends ConsumerWidget {
  const AcxTxnPlanList(
      {super.key,
      required this.diaLoghiddenFields,
      required this.diaLogquerySaveSql,
      required this.listquery,
      this.listIdField = "PlanId",
      this.listNoRecordTitle = "No Record",
      this.listTitle = "Fee Plan",
      this.listTitlefield = "Dscp",
      this.listDeleteParam,
      this.listDeleteSql,
      this.listNoPlanTitle = "No Plan",
      this.listItemTitle = "Fee Plan",
      required this.dialogParams,
      required this.dialogqueryRetrieveSql,
      this.feeCtgry});

  final Map<String, dynamic> diaLoghiddenFields;
  final String diaLogquerySaveSql;
  final Map<String, dynamic> dialogParams;
  final String dialogqueryRetrieveSql;

  final QueryObject listquery;
  final String listIdField;
  final String listNoRecordTitle;
  final String listNoPlanTitle;
  final String listTitle;
  final String listItemTitle;
  final String listTitlefield;
  final Map<String, dynamic>? listDeleteParam;
  final String? listDeleteSql;
  final String? feeCtgry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = listquery;

    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
      data: (returnData) {
        if (returnData.data == null) {
          return SizedBox(
            height: 300,
            child: Expanded(child: Text(listNoRecordTitle)),
          );
        }
        if (returnData.data![0][listIdField] == null) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 1280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> newRecordDialogParam =
                            Map.from(dialogParams);
                        newRecordDialogParam[listIdField] = null;
                        await showAcxDialog(
                            context,
                            AcxVwTxnPlanForm(
                              feeCtgry: feeCtgry,
                              hiddenFields: diaLoghiddenFields,
                              querySaveSql: diaLogquerySaveSql,
                              query: QueryObject(
                                params: newRecordDialogParam,
                                showMsg: false,
                                querysql: dialogqueryRetrieveSql,
                              ),
                            ));

                        ref.invalidate(ReturndatafreezedProvider(query));
                      },
                      child: const Icon(Icons.post_add)),
                  Text(listNoPlanTitle),
                  Text(listNoRecordTitle)
                  // ListView(
                  //                 children:  [Text(listNoRecordTitle)],
                  //               )
                ],
              ),
            ),
          );
        }

        return ListView(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        Map<String, dynamic> newRecordDialogParam =
                            Map.from(dialogParams);
                        newRecordDialogParam[listIdField] = null;
                        await showAcxDialog(
                            context,
                            AcxVwTxnPlanForm(
                                feeCtgry: feeCtgry,
                                hiddenFields: diaLoghiddenFields,
                                querySaveSql: diaLogquerySaveSql,
                                query: QueryObject(
                                    params: newRecordDialogParam,
                                    querysql: dialogqueryRetrieveSql,
                                    showMsg: false)));

                        ref.invalidate(ReturndatafreezedProvider(query));
                      },
                      icon: const Icon(Icons.post_add)),
                ],
              ),
              Text(listTitle),
              SizedBox(
                height: 1280,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: returnData.rowcount!,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    final currentData = returnData.data![index];
                    return ListTile(
                      onTap: () async {
                        Map<String, dynamic> recordDialogParam =
                            Map.from(dialogParams);
                        recordDialogParam[listIdField] =
                            currentData[listIdField].toString();
                        await showAcxDialog(
                            context,
                            AcxVwTxnPlanForm(
                                feeCtgry: feeCtgry,
                                hiddenFields: diaLoghiddenFields,
                                querySaveSql: diaLogquerySaveSql,
                                query: QueryObject(
                                    querysql: dialogqueryRetrieveSql,
                                    params: recordDialogParam,
                                    showMsg: false)));
                      },
                      title: Text(currentData[listTitlefield].toString()),
                      subtitle: Text(
                          '${fmtDateStrShort(currentData['FromDate'])} to ${fmtDateStrShort(currentData['ToDate'])} Creation Date ${fmtDateStrLong(currentData['CrtionDate'] ?? '')}'),
                      trailing: listDeleteParam == null
                          ? const SizedBox(width: 50)
                          : IconButton(
                              onPressed: () async {
                                bool confirmed = await ConfirmDialog.show(
                                  title: "Delete?",
                                  body: "Are you sure you want to Delete?",
                                  destructive: true,
                                  confirmText: "Yes",
                                  cancelText: "Cancel",
                                );

                                if (!confirmed) {
                                  return;
                                }
                                Map<String, dynamic> deleteparam =
                                    listDeleteParam!.map(
                                  (key, value) {
                                    value = currentData[key].toString();
                                    return MapEntry(key, value);
                                  },
                                );

                                final queryDel = QueryObject(
                                    querysql: listDeleteSql.toString(),
                                    params: deleteparam,
                                    showMsg: false);
                                await ref
                                    .read(ReturndatafreezedProvider(queryDel)
                                        .future)
                                    .then((value) {
                                  Toast.showresult(value);
                                  ref.invalidate(
                                      ReturndatafreezedProvider(query));
                                });
                              },
                              icon: const Icon(Icons.delete)),
                    );
                  },
                ),
              ),
            ]);
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()),);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
