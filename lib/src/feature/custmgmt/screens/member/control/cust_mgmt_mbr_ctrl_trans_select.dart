import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_select.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=634;

@RoutePage()
class CustMgmtMemberCtrlTransSelect extends ConsumerWidget {
  const CustMgmtMemberCtrlTransSelect({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('mbrEttyId') this.mbrEttyId,
  });

  final String? custEttyId;
  final String? mbrEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var prgSelect = ref.watch(custMgmtMbrCtrlTxnPrgSelectProvider);
    if (prgSelect == {}) {
      singleton<AppRouter>().back();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectableText(
              'Transaction Category and Spending Limit at Company level'),
          ElevatedButton(
              onPressed: () {},
              child: const SelectableText("Select target Program to set")),
          AcxListButtonNavWrapSelect(
              querysql: '/sp/ApiMgmtMbrTxnLimitPrgList/queryasync',
              toWatch: custMgmtMbrCtrlTxnPrgSelectProvider,
              params: {"CustEttyId": custEttyId, "MbrEttyId": mbrEttyId},
              returnSelectedRef: (val) {
                ref.read(custMgmtMbrCtrlTxnPrgSelectProvider.notifier).state =
                    val;
              },
              displayfield: const ['PrgDscp'],
              keyField: 'PrgEttyId'),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            sbw10,
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    sbh10,
                    ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> selectedPrg =
                            ref.read(custMgmtMbrCtrlTxnPrgSelectProvider);

                        if (selectedPrg.toString() == '{}') {
                          Toast.message(
                              'Please select program before proceeding');
                        } else {
                          singleton<AppRouter>().navigatePath(
                              '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt/detail/${selectedPrg['PrgEttyId']}/new');
                        }
                      },
                      child: const SelectableText(">>"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(custMgmtMbrCtrlTxnPrgSelectProvider.notifier)
                            .state = {};
                        singleton<AppRouter>().navigatePath(
                            '/custmgmt/member/$custEttyId/detail/$mbrEttyId/control/translimt');
                      },
                      child: const Icon(
                        Icons.backspace_outlined,
                      ),
                    )
                  ],
                ))
          ]),
        ],
      ),
    );
  }
}
