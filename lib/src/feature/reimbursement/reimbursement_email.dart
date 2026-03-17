import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatav3.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=184;

@RoutePage()
class ReimbursementFileOutEmail extends ConsumerWidget {
  const ReimbursementFileOutEmail({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    return buildView(context);
  }

  

}

Widget buildView(
  BuildContext context,
) {
  return const Scaffold(
    body:  RptEmailReimburseAutoGenSearchSliver(),
    // appBar: AppBar(
    //   title: const SelectableText('Schedule Report'),
    //   automaticallyImplyLeading: false, centerTitle: false,
    // ),
  );
}
class RptEmailReimburseAutoGenSearchSliver extends ConsumerWidget {
  const RptEmailReimburseAutoGenSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final rptSearchFormKey = GlobalKey<FormBuilderState>();
    //final rptParam = ref.read(rptEmailSearchReimbursementProvider);
    Map<String, dynamic> formNewValue = {
      "PrcsDate": DateTime.now(),
    };
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('Emailed Merchant Statement'),
      automaticallyImplyLeading: false, centerTitle: false,
       
      ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: rptSearchFormKey,
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
                children: [
                Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

                         
                 
    ],),
    sbh10,
    SizedBox(
      height: 50,
      child: FbDateTimePicker(label: 'Process Date', name: 'PrcsDate',))
                  // Row(
                  //   children: [
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 8),
                  //       child: Icon(Icons.calendar_month),
                  //     ),
                  //     sbw20,
                  //     Expanded(child: FbDateTimePicker(label: 'Process Date', name: 'PrcsDate',),),

                  //   ],
                  // ),
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
                          onPressed: () {
                            rptSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                convertFormDateValue(
                                    rptSearchFormKey.currentState!.value,
                                    ['PrcsDate']);
                            ref
                                .read(rptEmailSearchReimbursementProvider.notifier)
                                .state = toPost;
                          },
                          icon: const Icon(Icons.search)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
              ),
            )
          ]),),
     const SliverFillRemaining(child: TxnEmailReimburseGridSearch(),)
    ],
  );

  }
}

class TxnEmailReimburseGridSearch extends ConsumerWidget {
  const TxnEmailReimburseGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(rptEmailSearchReimbursementProvider);
    final query = QueryObject(
        querysql: '/sp/ApiTaskEmailNudgeList/queryasync',
        params: toPost,
        showMsg: false);
     late void Function(QueryObject returndata) myMethod;
    final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtv3(
            checkIndicatorField: 'EmailId',
             useCheckBox:true,
               builder: (BuildContext context, 
               void Function(QueryObject A) methodA) { 
                  myMethod = methodA;
                 },
            appButtons: [     AppButtonWithFunction(
                              btn: const AppButton(
                                icon: Icons.check_outlined,
                                label: "Resend Email",
                              ),
                              func: (List<TrinaRow<dynamic>> row) async {
                               if(row.isEmpty){
                                Toast.message("Please Check Rows to Proceed");
                                return;
                              }
                                if (context.mounted) {
                                  if(row.length == theData.data!.length){
                                     reSendAllEmail(ref,row.first,query);
                                    Toast.message('Sending to All');
                                  }
                                  else{
                                  reSendEmail(ref,row.toSet(),query);
                                  Toast.message('Sending to checked Records');
                                  }
                               
                                       myMethod.call(query);
                                }
                              }),],
              gridTitle: '',
              extData: theData,
            );
        });
  }
}
 

final rptEmailSearchReimbursementProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    "PrcsDate": null
  };
});

void reSendAllEmail(WidgetRef ref,  TrinaRow row, QueryObject query, ) {
  final queryDel = QueryObject(
      querysql: '/sp/ApiTaskEmailNudgeSave/queryasync',
      params: {
          "PrcsDate": row.cells["ProcessDate"]!.value.toString(),
        "TagALL": 'Y',
          "EmailId": row.cells["EmailId"]!.value.toString(),
      },
      showMsg: false);
  ref.read(ReturndatafreezedProvider(queryDel).future).then((value) {
    Toast.showresult(value);
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {});
}

void reSendEmail(WidgetRef ref, Set<TrinaRow> rows, QueryObject query) {
  var futures = <Future>[];
  for (var i = 0; i < rows.length; i++) {
    final queryDel = QueryObject(
        querysql: '/sp/ApiTaskEmailNudgeSave/queryasync',
        params: {
          "PrcsDate": rows.elementAt(i).cells["ProcessDate"]!.value.toString(),
          "EmailId": rows.elementAt(i).cells["EmailId"]!.value.toString(),
        },
        showMsg: false);
    final resultDel = ref.read(ReturndatafreezedProvider(queryDel).future);
    futures.add(resultDel);
  }
  Future.wait(
    futures,
    eagerError: true,
  ).then((value) {
    List<dynamic> rtt = value;
    for (var element in rtt) {
      Toast.showresult(element);
    }
    ref.invalidate(ReturndatafreezedProvider(query));
  }).onError((error, stackTrace) {});
}