import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';


const mModuleName = 'mchtmgmt';

const int wid=734;

@RoutePage()
class MchtMgmtDocLanding extends HookConsumerWidget {
  const MchtMgmtDocLanding({
    super.key,
    @PathParam.inherit('mchtEttyId') this.mchtEttyId,
  });

  final String? mchtEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
            return AcxTabView(
                  align: Alignment.centerLeft,
                  routes: [MchtMgmtDocAppl(
                moduleName: mModuleName,
                ettyId: mchtEttyId,
                rpstryType: "APP")],
                  tabs: [Tab(text: "Application",)],
                            );
    // final theResult = useState<Map<String, dynamic>>(
    //     {"EttyId": mchtEttyId, "RpstryType": null});
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
    //           MchtMgmtDocAppl(
    //               moduleName: mModuleName,
    //               ettyId: mchtEttyId,
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
  }
}
