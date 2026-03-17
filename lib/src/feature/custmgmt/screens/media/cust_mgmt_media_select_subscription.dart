import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_select.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';

import '../../../../core/components/formbuilder/fb_imports.dart';

const int wid=328;

@RoutePage()
class CustMgmtMediaSubSelect extends ConsumerWidget {
  const CustMgmtMediaSubSelect(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaCustMgmtMediaHolderNameProvider);
    final mediaCostCenterEtty =
        ref.watch(mediaCustMgmtCostCenterEttyIdProvider);
    //mediaMediaPrgSelectProvider
    final mediaMediaPrgSelect = ref.watch(mediaCustMgmtMediaPrgSelectProvider);
    final mediaMediaCategorySelect =
        ref.watch(mediaCustMgmtMediaCategorySelectProvider);
    if (mediaHolderName == '') {
      singleton<AppRouter>().navigatePath('/custmgmt/media/$custEttyId/list');
    }

    return Column(
      children: [
        SelectableText("Selected Mediaholder: $mediaHolderName"),
        const Center(
          child: SelectableText('Select Media Program and Category'),
        ),
        Row(
          children: [
            AcxListButtonNavWrapSelect(
                querysql: '/sp/ApiMgmtMediaAddOnSubscribePrgList/queryasync',
                toWatch: mediaCustMgmtMediaPrgSelectProvider,
                params: {
                  "CustEttyId": custEttyId,
                  "MbrEttyId": mediaCostCenterEtty["MbrEttyId"]
                },
                returnSelectedRef: (val) {
                  ref.read(mediaCustMgmtMediaPrgSelectProvider.notifier).state =
                      val;
                },
                displayfield: const ['PrgDscp'],
                keyField: 'PrgEttyId'),
            Flexible(
             child: FbLibView(
                showClearBtn: false,
                name: 'MediaCtgry',
                initialValue: mediaMediaCategorySelect['MediaCtgry'],
                label: 'Category',
                params: {'PrgEttyId': mediaMediaPrgSelect['PrgEttyId']},
                keyField: 'MediaCtgry',
                searchText: 'Dscp',
                querySql: '/sp/ApiPrgMediaCtgryList/queryasync',
                // onClearPress: () {
                //   ref.read(mediaCustMgmtCostCenterEttyIdProvider.notifier).state = {"MediaCtgry": null};
                // },
                returnSelectedRef: (val) {
                  ref
                      .read(mediaCustMgmtMediaCategorySelectProvider.notifier)
                      .state = {
                    "MediaCtgry": val['MediaCtgry'],
                    "Dscp":val['Dscp']
                  };
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  singleton<AppRouter>()
                      .navigatePath('/custmgmt/media/$custEttyId/selmedia');
                },
                child: const Icon(Icons.arrow_back)),
            mediaMediaPrgSelect["PrgEttyId"] == null ||
                    mediaMediaCategorySelect["MediaCtgry"] == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      //mediaCostCenterEtty
                      //mediaCustMgmtCostCenterEttyIdProvider
                      ref
                          .read(mediaCustMgmtCostCenterEttyIdProvider.notifier)
                          .state = {"MediaCtgry": null};
                      singleton<AppRouter>().navigatePath(
                          '/custmgmt/media/$custEttyId/detailAddOn/${mediaMediaCategorySelect['MediaCtgry']}/${mediaMediaPrgSelect['PrgEttyId']}/${mediaCostCenterEtty['MbrEttyId']}/${mediaCostCenterEtty['MediaId']}');
                    },
                    child: const Icon(Icons.arrow_forward)),
          ],
        )
      ],
    );
  }
}

class DropDownMediaForm extends ConsumerWidget {
  const DropDownMediaForm({super.key, required this.custEttyId});
  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final dropDownMediaFormFormKey = GlobalKey<FormBuilderState>();

    final val = ref.watch(mediaCustMgmtCostCenterEttyIdProvider);
    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": val["CmpyEttyId"],
      "CostCtrEttyId": val["CostCtrEttyId"],
      "MbrEttyId": val["MbrEttyId"],
    };

    return FormBuilder(
      key: dropDownMediaFormFormKey,
      initialValue: formNewValue,
      child: Column(children: [
        FbLibView(
            name: 'CustEttyId',
            keyField: 'CmpyEttyId',
            label: 'Company',
            querySql: "/sp/ApiMgmtMediaAddOnCmpyList/queryasync",
            searchText: 'CmpyName',
            params: {"CustEttyId": custEttyId})
      ]),
    );
  }
}
