import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';
import '../../../../../core/app_router.gr.dart';

const mModuleName = 'custenroll';

const int wid=480;

@RoutePage()
class CustEnrollDocLanding extends HookConsumerWidget {
  const CustEnrollDocLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
              return AcxTabView(
                  align: Alignment.centerLeft,
                  routes: [CustEnrollDocAppl(
                moduleName: mModuleName,
                ettyId: custEttyId,
                rpstryType: "APP")],
                  tabs: [Tab(text: "Application",)],
                            );
  }}
                       
  
    //below we use multiple result and loop. since we only want to maintain APP we just use 1 instead
    // final theResult = useState<Map<String, dynamic>>(
    //     {"EttyId": custEttyId, "RpstryType": null});
    // final query = QueryObject(
    //     querysql: '/sp/ApiEnrlDocList/queryasync',
    //     params: theResult.value,
    //     showMsg: false);

    // final formData = ref.watch(ReturndatafreezedProvider(query));
    // List<PageRouteInfo<dynamic>> toAdd = [];
    // List<Tab> tabsToAdd = [];
    // return formData.when(
    //   data: (d) {
    //     ref.read(s3SelectedRowProvider.notifier).state = '';

    //     if (d.data != null) {
    //       for (var element in d.data!) {
    //         toAdd.add(
    //           CustEnrollDocAppl(
    //               moduleName: mModuleName,
    //               ettyId: custEttyId,
    //               rpstryType: element['RpstryType']),
    //         );
    //         tabsToAdd.add(Tab(
    //           text: element['RpstryTypeDscp'].toString(),
    //         ));
    //       }
    //       return Column(
    //         children: [
    //           Expanded(
    //             flex: 12,
    //             child: AcxTabView(
    //                 align: Alignment.centerLeft,
    //                 routes: toAdd,
    //                 tabs: tabsToAdd),
    //           ),
    //         ],
    //       );
    //     }
    //     return Container();
    //   },
    //   error: (error, stackTrace) => Center(child: Text(error.toString()),),
    //   loading: () => const Center(child: CircularProgressIndicator()),
    // );
//   }
// }
