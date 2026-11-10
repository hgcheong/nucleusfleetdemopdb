import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_back_to_list.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custenroll/screens/media/cust_enroll_media_provider.dart';

const int wid=291;

@RoutePage()
class CustEnrollMediaSelect extends ConsumerWidget {
  const CustEnrollMediaSelect(
      {super.key, @PathParam.inherit('custEttyId') this.custEttyId});

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(mediaCostCenterEttyIdProvider);
    final custEnrollCmpyFormKey = GlobalKey<FormBuilderState>();
    Map<String, dynamic> formNewValue = {
      "CustEttyId": custEttyId,
      "CmpyEttyId": val['CmpyEttyId'],
      "CostCtrEttyId": val['CostCtrEttyId'],
      "MbrEttyId": val['MbrEttyId']
    };
    return FormBuilder(
        key: custEnrollCmpyFormKey,
        initialValue: formNewValue,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 1280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FbHiddenText(name: 'CustEttyId'),
                      const SelectableText("Select MediaHolder"),
                      FbLibView(
                        showClearBtn: false,
                        name: 'CmpyEttyId',
                        initialValue: val['CmpyEttyId'].toString(),
                        label: 'Company',
                        params: {"CustEttyId": custEttyId},
                        keyField: 'CmpyEttyId',
                        searchText: 'CmpyName',
                        querySql: '/sp/ApiEnrlMediaCmpyList/queryasync',
                        returnSelectedRef: (val) async {
                         await Future.delayed(Duration(milliseconds: 200), (){
  ref
                              .read(mediaCostCenterEttyIdProvider.notifier)
                              .state = {
                            "CustEttyId": val["CustEttyId"],
                            "CmpyEttyId": val["CmpyEttyId"],
                            "CostCtrEttyId": null,
                            "MbrEttyId": null
                          };
                          });
                        
                        },
                      ),
                      val["CmpyEttyId"] == null
                          ? const SelectableText("Please Select Company")
                          : FbLibView(
                            showClearBtn: false,
                              name: 'CostCtrEttyId',
                              initialValue: val['CostCtrEttyId'].toString(),
                              label: 'Cost Center',
                              params: {
                                "CustEttyId": custEttyId,
                                "CmpyEttyId": val['CmpyEttyId'].toString(),
                              },
                              keyField: 'CostCtrEttyId',
                              searchText: 'CostCtrDscp',
                              querySql:
                                  '/sp/ApiEnrlMediaCostCtrList/queryasync',
                              returnSelectedRef: (val) async {

                                      await Future.delayed(Duration(milliseconds: 200), (){
   ref
                                    .read(
                                        mediaCostCenterEttyIdProvider.notifier)
                                    .state = {
                                  "CustEttyId": val["CustEttyId"],
                                  "CmpyEttyId": val["CmpyEttyId"],
                                  "CostCtrEttyId": val["CostCtrEttyId"],
                                  "MbrEttyId": null
                                };
                                      });
                             
                              },
                            ),
                      val["CostCtrEttyId"] == null
                          ? const SelectableText("Please Select cost Center")
                          : DynamicDMember(
                              custEttyId: custEttyId.toString(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                // ElevatedButton(onPressed: () {}, child: const Icon(Icons.save)),
                AcxBackToList(
                  listUrl: '/custenroll/media/$custEttyId/list',
                  fnBeforeNav: () {
                    ref.read(mediaCostCenterEttyIdProvider.notifier).state = {
                      "CustEttyId": null,
                      "CmpyEttyId": null,
                      "CostCtrEttyId": null,
                      "MbrEttyId": null
                    };
                  },
                ),
                val['MbrEttyId'] == null
                    ? const SelectableText('No Member')
                    : ElevatedButton(
                        onPressed: () {
                          singleton<AppRouter>().navigatePath(
                              '/custenroll/media/$custEttyId/selsub');
                        },
                        child: const Icon(Icons.arrow_forward))
              ]),
            )
          ],
        ));
  }
}

class DynamicDMember extends ConsumerWidget {
  const DynamicDMember({super.key, required this.custEttyId});

  final String custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(mediaCostCenterEttyIdProvider);
    final toPass = {
      "CmpyEttyId": val["CmpyEttyId"],
      "CustEttyID": custEttyId,
      "CostCtrEttyId": val["CostCtrEttyId"]
    };

    final queryObject = QueryObject(
        querysql: '/sp/ApiEnrlMediaMbrList/queryasync',
        params: toPass,
        showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data![0]['MbrEttyId'] == null) {
            return const Row(
              children: [
                Expanded(child: SelectableText('Please create Member ')),
              ],
            );
          } else {
            return FbLibViewExt(
              showClearBtn: false,
                showSearchBox: true,
              name: 'MbrEttyId',
              datasrc: re,
              initialValue: val['MbrEttyId'].toString(),
              label: 'Attached to Member',
              keyField: 'MbrEttyId',
              searchText: 'MbrName',
              returnSelectedRef: (Map<String, dynamic> val) async {

              await Future.delayed(Duration(milliseconds: 200),(){
    ref.read(mediaMediaHolderNameProvider.notifier).state =
                    "${val['MbrName']} ${val['VhcRgsNo'] ?? ''}";
                });
            await Future.delayed(Duration(milliseconds: 200), (){
  ref.read(mediaCostCenterEttyIdProvider.notifier).state = {
                  "CustEttyId": val["CustEttyId"],
                  "CmpyEttyId": val["CmpyEttyId"],
                  "CostCtrEttyId": val["CostCtrEttyId"],
                  "MbrEttyId": val["MbrEttyId"]
                };
            });
              
              },
            );
          }
        });
  }
}

class DynamicDostCentre extends ConsumerWidget {
  const DynamicDostCentre({
    super.key,
    required this.custEttyId,
  });

  final String custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final val = ref.watch(mediaCostCenterEttyIdProvider);
    final toPass = {"CmpyEttyId": val["CmpyEttyId"], "CustEttyId": custEttyId};

    final queryObject = QueryObject(
        querysql: '/sp/ApiEnrlMediaCostCtrList/queryasync',
        params: toPass,
        showMsg: false);
    final dataSrc = ref.watch(ReturndatafreezedProvider(queryObject));
    return AsyncValueWidget(
        value: dataSrc,
        data: (re) {
          if (re.data![0]['CostCtrEttyId'] == null) {
            return const Row(
              children: [
                Expanded(
                    child: SelectableText('Please create cost Center Code')),
              ],
            );
          } else {
            return FbLibViewExt(
              showClearBtn: false,
              name: 'CostCtrEttyId',
              datasrc: re,
              initialValue: val['CostCtrEttyId'].toString(),
              label: 'Attached to Cost Centre',
              keyField: 'CostCtrEttyId',
              searchText: 'CostCtr',
              returnSelectedRef: (Map<String, dynamic> val) async {
                await Future.delayed(Duration(milliseconds: 200), (){
     ref.read(mediaCostCenterEttyIdProvider.notifier).state = {
                  "CustEttyId": val["CustEttyId"],
                  "CmpyEttyId": val["CmpyEttyId"],
                  "CostCtrEttyId": val["CostCtrEttyId"],
                  "MbrEttyId": null
                };
                });
           
              },
            );
          }
        });
  }
}
