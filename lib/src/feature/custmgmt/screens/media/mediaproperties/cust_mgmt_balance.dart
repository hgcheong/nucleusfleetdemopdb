import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/media/cust_mgmt_media_provider.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const int wid=614;

@RoutePage()
class CustMgmtMediaBalance extends ConsumerWidget {
  const CustMgmtMediaBalance(
      {super.key,
      @PathParam.inherit('mediaEttyId') this.mediaEttyId});


  final String? mediaEttyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final qoFormData = QueryObject(
        querysql: '/sp/RpeDrivewayMediaBal/queryasyncoltp',
        params: {
          "MediaNo": null,
          "EttyId": convStrNewOrNullToNull(mediaEttyId)
        },
        showMsg: true);

    // return AsyncValueWidget<Returndata>(value: theData, data: (theResul) {});
    final formData = ref.watch(ReturndatafreezedProvider(qoFormData));

    return AsyncValueWidget(
        value: formData,
        data: (theData) {
          if(theData.data==null || theData.data!.isEmpty){
            return const Center(child: Text('No Data'),);
          }
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: IconButton(onPressed: (){
              ref.invalidate(ReturndatafreezedProvider(qoFormData));
            }, icon: Icon(Icons.refresh))),
            Expanded(
              child: Wrap(
                    children: [
                      ...theData.data!.map((e) { 
                      var availBal  =  e['MaxThsld']- e['UtlzedAmt']- e['ExpsrAmt'] + e['RevokeAmt'];
                      var toDisplay = switch (e['LimitType']) {
                        'DAY' => 'Daily Limit',
                        'SINGLE' => 'Single Transaction Limit',
                        'MTH' => 'Monthly Limit',
                        _ => 'Unknown Balance'
                      };
                          return   CardBalance(
                            title: toDisplay,
                            width: 300,
                            child: CircularPercentIndicator(
                                              radius: 100.0,
                                              lineWidth: 12.0,
                                              percent: e['MaxThsld']==0 ? 0.0 : (availBal / e['MaxThsld']).toDouble(),
                                              center:  Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                 SelectableText("${e['MaxThsld']==0 ? 0.0 : (availBal / e['MaxThsld']).toDouble()*100}%"),
                                 SelectableText('Available: MYR${availBal.toStringAsFixed(2)}'),         
                                SelectableText('Maximum: MYR${e['MaxThsld'].toStringAsFixed(2)}'),
                                
                       
                              ],
                            ),
                                              ),
                                              progressColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                            ),
                          );
                      
                      }),
                    
                    ],
                
                ),
            ),
          ],
        );
        });
  }
}

class MediaPropertiesHdr extends StatelessWidget {
  const MediaPropertiesHdr({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: const Row(
        children: [
          Flexible(
              child: Column(
            children: [
              SelectableText('Media Holder'),
              SelectableText('Program'),
              SelectableText('PostPaid')
            ],
          )),
          Flexible(
              child: Column(
            children: [
              SelectableText(''),
              SelectableText('Media Category'),
              SelectableText('Vehicle Card')
            ],
          )),
          Flexible(
              child: Column(
            children: [SelectableText(''), SelectableText('1a')],
          )),
        ],
      ),
    );
  }
}

class MediaPropertiesHdr2 extends ConsumerWidget {
  const MediaPropertiesHdr2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final mediaHolderName = ref.watch(mediaCustMgmtMediaHolderNameProvider);
    // final mediaMediaPrgSelect = ref.watch(mediaCustMgmtMediaPrgSelectProvider);
    // final mediaMediaCategorySelect =
    //     ref.watch(mediaCustMgmtMediaCategorySelectProvider);
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          Row(
            children: [
              const SelectableText('Media Holder'),
              SelectableText(mediaHolderName),
            ],
          ),
          // const Row(
          //   children: [
          //     SelectableText('Program'),
          //     sbw10,
          //     SelectableText('Media Category'),
          //   ],
          // ),
          // Row(
          //   children: [
          //     SelectableText(mediaMediaPrgSelect['PrgDscp'] ?? ''),
          //     sbw10,
          //     SelectableText(mediaMediaCategorySelect['Dscp'] ?? '')
          //   ],
          // ),
        ],
      ),
    );
  }
}

class CardBalance extends StatelessWidget {
  const CardBalance({
    super.key,
    required this.child,
    this.title,
    this.titleAlign = Alignment.topLeft,
    this.height = 300,
    this.width = 300,
  });

  final Widget child;
  final String? title;
  final Alignment titleAlign;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SizedBox(
        // decosration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)), border: Border.all(color: Colors.blue)),
        height: height,
        width: width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                title == null
                    ? Container()
                    : Align(
                        alignment: titleAlign,
                        child: SelectableText(
                          title.toString(),
                          //      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                sbh20,
                child,
              ],
            ),
          ),
        ));
  }
}
