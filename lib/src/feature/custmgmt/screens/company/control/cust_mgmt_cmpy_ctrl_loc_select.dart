import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_select.dart';
import 'package:nucleusv2/src/feature/custmgmt/custmgmt_controller.dart';

const int wid=546;

@RoutePage()
class CustMgmtCmpyCtrlLocSelect extends ConsumerWidget {
  const CustMgmtCmpyCtrlLocSelect({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
    @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
  });

  final String? custEttyId;
  final String? cmpyEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var prgSelect = ref.watch(custMgmtCmpyCtrlLocPrgSelectProvider);
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
              querysql: '/sp/ApiMgmtCmpyLocAccptPrgList/queryasync',
              toWatch: custMgmtCmpyCtrlLocPrgSelectProvider,
              params: {"CustEttyId": custEttyId, "CmpyEttyId": cmpyEttyId},
              returnSelectedRef: (val) {
                ref.read(custMgmtCmpyCtrlLocPrgSelectProvider.notifier).state =
                    val;
              },
              displayfield: const ['PrgDscp', 'BillingLevel'],
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
                            ref.read(custMgmtCmpyCtrlLocPrgSelectProvider);

                        if (selectedPrg.toString() == '{}') {
                          Toast.message(
                              'Please select program before proceeding');
                        } else {
                          singleton<AppRouter>().navigatePath(
                              '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt/detail/${selectedPrg['PrgEttyId']}/new');
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
                            .read(custMgmtCmpyCtrlLocPrgSelectProvider.notifier)
                            .state = {};
                        singleton<AppRouter>().navigatePath(
                            '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/control/locaccpt');
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
