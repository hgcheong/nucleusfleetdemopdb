import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=887;

@RoutePage()
class SystemConfigLogReqSpList extends ConsumerWidget {
  const SystemConfigLogReqSpList({super.key});
  
 @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
     final qo = QueryObject(
        querysql: '/sp/ApiLogReqSpList/queryasync',
        params: {
          'SpName':null
        },
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
              checkIndicatorField: "Id",
              onSelected: (TrinaRow val){
                         singleton<AppRouter>().navigatePath(
              '/systemconfig/logreq/dtl/${val.cells['Id']!.value.toString()}').then((val){
                myMethod.call(qo);
              });
              },
              onRefresh: (){
                    myMethod.call(qo);
              },);
       });
  }


}
