import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';


const mModuleName = 'custmgmt';

const int wid=593;

@RoutePage()
class CustMgmtDocLanding extends HookConsumerWidget {
  const CustMgmtDocLanding({
    super.key,
    @PathParam.inherit('custEttyId') this.custEttyId,
  });

  final String? custEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //Get the EnrlId
    final qo = QueryObject(querysql:'/sp/ApiMgmtCust/queryasync', params: {
      "CustEttyId":custEttyId
    }, showMsg: false);


    final res = ref.watch(ReturndatafreezedProvider(qo));
    return res.when(data: (d){
        if(d.data ==null || d.data![0]["EnrlId"] ==null){
          return Center(child:Text("Enrolment Reference not Found"));
        }
              return AcxTabView(
                  align: Alignment.centerLeft,
                  routes: [CustMgmtDocAppl(
                moduleName: "custenroll",
                ettyId: d.data![0]["EnrlId"].toString(),
                rpstryType: "APP")],
                  tabs: [Tab(text: "Application",)],
                            );
    },
      error: (error, stackTrace) => Center(child: Text(error.toString()),),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
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
    //           CustMgmtDocAppl(
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
  }
}
