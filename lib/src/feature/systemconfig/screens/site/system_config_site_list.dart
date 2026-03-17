import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_controller.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=887;

@RoutePage()
class SystemConfigSiteList extends ConsumerWidget {
  const SystemConfigSiteList({super.key});
  
 @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
     final qo = QueryObject(
        querysql: '/sp/ApiMgmtSiteList/queryasync',
        params: {},
        showMsg: false);
           final queryRes = ref.watch(ReturndatafreezedProvider(qo));
              late void Function(QueryObject returndata) myMethod;
       return AsyncValueWidget(value: queryRes, data: (theData){

     return AcxTrinaGridExtv3(
               builder: (BuildContext context, 
               void Function(QueryObject A) methodA) { 
                  myMethod = methodA;
                 },
               useCheckBox:false,

           //   gridTitle: 'Site Settings',
              extData: theData,
              checkIndicatorField: "SiteId",
              onNew: (){
                            singleton<AppRouter>().navigatePath(
              '/systemconfig/site/dtl/new');
              },
              onDelete: (TrinaRow<dynamic> val){
                        if (val.cells == {})
        {
           Toast.message("Please select row to delete");
           return;
        }
   
                        final saveResult = ref.read(ReturndatafreezedProvider(
                                QueryObject(
                                    querysql: '/sp/ApiMgmtSiteDel/queryasync',
                                    params: {
                                       "SiteId":val.cells["SiteId"]!.value.toString(),
                                      // "SiteCd":val.cells["SiteCd"]!.value.toString()
                                    },
                                    showMsg: false))
                            .future);
                        saveResult.then((Returndata? value) {
                          if(value==null){
                            return;
                          }
                          Toast.showresult(value);
                            myMethod.call(qo);
                        });
              },
              onSelected: (TrinaRow val){
                    ref.read(myStateCityProvider.notifier).state = "";
                         singleton<AppRouter>().navigatePath(
              '/systemconfig/site/dtl/${val.cells['SiteId']!.value.toString()}').then((val){
                myMethod.call(qo);
              });
              },
              onRefresh: (){
                    myMethod.call(qo);
              },);
       });
  }


}
