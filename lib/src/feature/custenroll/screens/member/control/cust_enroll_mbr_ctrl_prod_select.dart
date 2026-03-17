import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_select.dart';
import 'package:nucleusv2/src/feature/custenroll/custenroll_controller.dart';

const int wid=516;

@RoutePage()
class CustEnrollMemberCtrlProdSelect extends ConsumerWidget {
  const CustEnrollMemberCtrlProdSelect({
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
    var prgSelect = ref.watch(custEnrollMbrCtrlTxnPrgSelectProvider);
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
              'Transaction Category and Spending Limit at Member level'),
          ElevatedButton(
              onPressed: () {},
              child: const SelectableText("Select target Program to set")),
          AcxListButtonNavWrapSelect(
              querysql: '/sp/ApiEnrlMbrPrdAccptList/queryasync',
              toWatch: custEnrollMbrCtrlTxnPrgSelectProvider,
              params: {"CustEttyId": custEttyId, "MbrEttyId": mbrEttyId},
              returnSelectedRef: (val) {
                ref.read(custEnrollMbrCtrlTxnPrgSelectProvider.notifier).state =
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
                            ref.read(custEnrollMbrCtrlTxnPrgSelectProvider);

                        if (selectedPrg.toString() == '{}') {
                          Toast.message(
                              'Please select program before proceeding');
                        } else {
                          singleton<AppRouter>().navigatePath(
                              '/custenroll/member/$custEttyId/detail/$mbrEttyId/control/prodaccpt/detail/${selectedPrg['PrgEttyId']}');
                        }
                      },
                      child: const SelectableText(">>"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        singleton<AppRouter>().navigatePath('./list');
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
