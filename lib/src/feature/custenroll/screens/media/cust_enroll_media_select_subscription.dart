import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap_select.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/media/cust_enroll_media_provider.dart';

import '../../../../core/components/formbuilder/fb_imports.dart';

const int wid=293;

@RoutePage()
class CustEnrollMediaSubSelect extends ConsumerWidget {
  const CustEnrollMediaSubSelect(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaMediaHolderNameProvider);
    final mediaCostCenterEtty = ref.watch(mediaCostCenterEttyIdProvider);
    //mediaMediaPrgSelectProvider
    final mediaMediaPrgSelect = ref.watch(mediaMediaPrgSelectProvider);
    final mediaMediaCategorySelect =
        ref.watch(mediaMediaCategorySelectProvider);
    if (mediaHolderName == '') {
      singleton<AppRouter>()
          .navigatePath('/custenroll/media/$custEttyId/list');
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
                querysql: '/sp/ApiEnrlMediaSubscribePrgList/queryasync',
                toWatch: mediaMediaPrgSelectProvider,
                params: {
                  "CustEttyId": custEttyId,
                  "MbrEttyId": mediaCostCenterEtty["MbrEttyId"]
                },
                returnSelectedRef: (val) {
                  ref.read(mediaMediaPrgSelectProvider.notifier).state = val;
                },
                deleteSelectedRef: (val) {
                  ref.read(mediaMediaPrgSelectProvider.notifier).state = {
                    "PrgEttyId": null
                  };
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
                //   ref.read(mediaMediaCategorySelectProvider.notifier).state = {"MediaCtgry": null};
                // },
                returnSelectedRef: (val) {
                  ref.read(mediaMediaCategorySelectProvider.notifier).state = {
                    "MediaCtgry": val['MediaCtgry'],
                    "Dscp":val['Dscp']
                  };
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(mediaMediaCategorySelectProvider.notifier).state = {
                    "MediaCtgry": null,
                    "Dscp":null
                  };
                  singleton<AppRouter>()
                      .navigatePath('/custenroll/media/$custEttyId/selmedia');
                },
                child: const Icon(Icons.arrow_back)),
            mediaMediaPrgSelect["PrgEttyId"] == null ||
                    mediaMediaCategorySelect["MediaCtgry"] == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      //mediaCostCenterEtty

                      singleton<AppRouter>().navigatePath(
                          '/custenroll/media/$custEttyId/detail/${mediaMediaCategorySelect['MediaCtgry']}/${mediaMediaPrgSelect['PrgEttyId']}/${mediaCostCenterEtty['MbrEttyId']}/new');
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

    final val = ref.watch(mediaCostCenterEttyIdProvider);
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
            querySql: "/sp/ApiEnrlMediaCmpyList/queryasync",
            searchText: 'CmpyName',
            params: {"CustEttyId": custEttyId})
      ]),
    );
  }
}
