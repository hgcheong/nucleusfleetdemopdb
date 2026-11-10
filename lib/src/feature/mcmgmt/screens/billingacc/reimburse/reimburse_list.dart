import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/reimburse/reimburse_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=704;

@RoutePage()
class MchtMgmtReimburseList extends ConsumerWidget {
  const MchtMgmtReimburseList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
    // @PathParam.inherit('prgEttyId') this.prgEttyId,
    // @PathParam.inherit('ettyId') this.ettyId,
    // @PathParam.inherit('acctId') this.acctId,
  });

  final String? mchtEttyId;
  // final String? prgEttyId;
  // final String? ettyId;
  // final String? acctId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final rebateFormKey = GlobalKey<FormBuilderState>();

    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
          const SelectableText(
            "Reimbursement Search",
          ),
          sbh10,
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: rebateFormKey,
                initialValue: {"MchtEttyId": mchtEttyId},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FbLibView(
                          inputIcon: const Icon(Icons.store),
                          params: {'MchtEttyId': mchtEttyId.toString()},
                          name: 'LocEttyId',
                          label: 'Location',
                          searchText: 'LocName',
                          keyField: 'LocEttyId',
                          querySql: spStr('ApiMgmtLocList')),
                    ),
                    sbw10,
                    Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                sbw10,
                                const Flexible(
                                    child: FbDateTimePicker(
                                        name: 'FromDate', label: 'From Date')),
                                fbFieldGap,
                                const Flexible(
                                    child: FbDateTimePicker(
                                        name: 'ToDate', label: 'To Date')),
                                sbw20,
                                IconButton(
                                    onPressed: () {
                                      rebateFormKey.currentState!.save();
                                      Map<String, dynamic> toPost =
                                          convertFormDateValue(
                                              rebateFormKey.currentState!.value,
                                              ['FromDate', 'ToDate']);
                                      ref
                                          .read(
                                              reimburseSearchContorllerProvider
                                                  .notifier)
                                          .state = toPost;
                                    },
                                    icon: const Icon(Icons.search))
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          // const SelectableText(
          //   'Reimbusements',
          // ),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  height: 1280,
                  child: ReimbusementGridPage(
                    mchtEttyId: mchtEttyId,
                  )))
        ]),
      ),
    );
  }
}

class ReimbusementGridPage extends ConsumerWidget {
  const ReimbusementGridPage({
    super.key,
    this.mchtEttyId,
  });

  final String? mchtEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final toPost = ref.watch(reimburseSearchContorllerProvider);
    toPost['MchtEttyId'] = mchtEttyId;
    final query = QueryObject(
        querysql: 'ApiMgmtMchtAcctReimburseList',
        params: toPost,
        showMsg: false);
    final queryRes = ref.watch(ReturndatafreezedProvider(query));

    return AsyncValueWidget(
        value: queryRes,
        data: (theData) {
          return SingleChildScrollView(
              child: SizedBox(
                  height: 1280,
                  child: AcxTrinaGridExtDatawExport(
                      gridTitle: 'Reimbursement',
                      extData: theData,
                      idField: 'BatchNo',
                      onSelected: (TrinaRow val) async {
                        //   showAcxDialog(context, const MchtMgmtReimbusementDetail());
                        Toast.message('Not Authorised to View Reimbusement');
                      })));
        });
  }
}
