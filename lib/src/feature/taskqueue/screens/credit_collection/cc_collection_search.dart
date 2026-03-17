import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/feature/taskqueue/screens/credit_collection/cc_collection_controller.dart';
import 'package:nucleusv2/src/feature/taskqueue/screens/credit_collection/cc_collection_mock.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=413;

@RoutePage()
class CreditCollecitonSearch extends ConsumerWidget {
  const CreditCollecitonSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
     final txnCollectionSearchKey = GlobalKey<FormBuilderState>();
    var toPost = ref.watch(txnCollectionContorllerProvider);
    final query = ReturndataProvider(
        querysql: '/sp/ApiTaskCollSearch/queryasync',
        params: {
    "CmpyName": toPost['CmpyName'],
    "AcctNo":toPost['AcctNo']
},showMsg: false);

  Map<String, dynamic> formNewValue = {
    "CmpyName":null,
    "AcctNo":null
};

    return ListView(children: [
      const Text("Collection Search"),
        sbh10,
          FormBuilder(
        key: txnCollectionSearchKey,
        initialValue: formNewValue,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                 //   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.food_bank),
                          ),
                          sbw20,
                           Expanded(
                              child:
                                   FbText(label: 'Company Name', name: 'CmpyName', initialValue: toPost['CmpyName']??"",)),
                        ],
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.point_of_sale),
                          ),
                          sbw20,
                          Expanded(
                              child:
                                  FbNumber(label: 'Account No', name: 'AcctNo')),
                        ],
                      ),
                    ],
                  ),
                ),
                sbw10,
    
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                txnCollectionSearchKey.currentState!.patchValue({'mydate': DateTime.now()});
                                txnCollectionSearchKey.currentState!.save();
                                Map<String, dynamic> toPost =txnCollectionSearchKey.currentState!.value;
                                ref.read(txnCollectionContorllerProvider.notifier).state = toPost;
                                             //  final query = QueryObject(
                                  //  querysql: '/sp/ApiTaskCollSearch/queryasync',
                                  // params: toPost,
                                  //  showMsg: false);
                                  // final data = await ref.watch(ReturndatafreezedProvider(query).future);
    
    
                              },
                              icon: const Icon(Icons.search)),IconButton(onPressed: (){
                                 ref.invalidate(query);
                              }, icon: const Icon(Icons.text_snippet))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
     SizedBox(
          height: 1280,
          child:  TxnCollectionSearch(query: query,))
       
      
    ],);
  }
}

class TxnCollectionSearch extends ConsumerWidget {
  const TxnCollectionSearch( {super.key,required this.query });

  final ReturndataProvider query;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

     final data = ref.watch(query);
     return AsyncValueWidget(value: data, data: (extdata){

//override external data
//apiTaskCollSearchMock

return AcxTrinaGridExtDatawExport(
           //spName: 'ApiTaskCollSearch',
              extData: apiTaskCollSearchMock,
              idField: 'TaskId',
              // popupIcon: const Icon(Icons.chevron_right),
              //      popMenuItems: const [
              //     {"value": "showmore", "text": "Show More"}
              //   ],
              //   onPopUp: (popVal) {
              //     print(popVal);
              //   },  
                  onSelected: (TrinaRow val) async {
                      ref.read(appBarTitleProvider.notifier).state = "Collection for ${val.cells['CustName']!.value.toString()}";
                 singleton<AppRouter>().navigatePath('/taskqueue/crcoldtl/${val.cells['TaskId']!.value.toString()}');
                 }
          );
      //  return AcxTrinaGridExtDataActionItems(
      //      spName: 'ApiTaskCollSearch',
      //         extData: apiTaskCollSearchMock,
      //         idField: 'TaskId',
      //         // popupIcon: const Icon(Icons.chevron_right),
      //         //      popMenuItems: const [
      //         //     {"value": "showmore", "text": "Show More"}
      //         //   ],
      //         //   onPopUp: (popVal) {
      //         //     print(popVal);
      //         //   },
              
      //             onSelectedTap: (TrinaRow val) async {
      //                 ref.read(appBarTitleProvider.notifier).state = "Collection for ${val.cells['CustName']!.value.toString()}";
      //            singleton<AppRouter>().navigatePath('/taskqueue/crcoldtl/${val.cells['TaskId']!.value.toString()}');
      //            }
      //     );
 
     });
  }
}
