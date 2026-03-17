import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

//With external query object so that I can refresh it
class AcxListButtonNavWrapManualDirector extends ConsumerWidget {
  const AcxListButtonNavWrapManualDirector(
      {super.key,
      required this.returnSelectedRef,
      required this.displayfield,
      required this.keyField,
      this.filterField,
      this.filterValue,
      this.deleteSelectedRef,
      this.addNew,
      this.selectedKey,
      required this.query});
  final List<String> displayfield;
  final Function returnSelectedRef;
  final String keyField;
  final String? filterField;
  final String? filterValue;
  final String? selectedKey;
  final Function? deleteSelectedRef;
  final Function? addNew;
  final QueryObject query;


        // {
        //     "DirectorshipDscp": "Director Only",
        //     "FullName": "Abdul Halim",
        //     "ShareHolding": 9.0000,
        //     "TtlShareHolding": 18.0000,
        //     "StsDscp": "ACTIVE",
        //     "Directorship": "2070",
        //     "Sts": "A",
        //     "EttyId": 318,
        //     "IndvdId": 198
        // }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(ReturndatafreezedProvider(query));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AsyncValueWidget<Returndata>(
        data: (Returndata returnData) {
          if (returnData.data == null) {
                        return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                const Text('No Record'),
                addNew != null
                    ? Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                            onPressed: () {
                              addNew!();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(24),
                            ),
                            child: const Icon(
                              Icons.add,
                            )),
                      )
                    : Container()
              ],
            );
          }
          if (returnData.data![0][keyField] == null) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbw54,
                const Text('No Record'),
                addNew != null
                    ? Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                            onPressed: () {
                              addNew!();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(24),
                            ),
                            child: const Icon(
                              Icons.add,
                            )),
                      )
                    : Container()
              ],
            );
          }
          List<Widget> toAdd = [];

          for (var i = 0; i < returnData.data!.length; i++) {
            if (filterField != null && filterValue != null) {
              if (returnData.data![i][filterField] != filterValue) {
                continue;
              }
            }
    
            toAdd.add(SizedBox(
              height: 150,
              width: 300.0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                  
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                         CircularPercentIndicator(
                                       radius: 45.0,
                                       lineWidth: 6.0,
                                       percent: returnData.data![i]["ShareHolding"]/100,
                                       center: SelectableText("${returnData.data![i]["ShareHolding"]}% \nShare"),
                                       progressColor: Colors.blue,
                                     ),
                        ],),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                                      
                            Flexible(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ...displayfield.map((element) {
                                        final val = returnData.data![i][element];
                                        if(element == 'ShareHolding'){
                                          return const SizedBox(height: 0,width: 0);
                                        }
                                        if (val != null) {
                                          return Text(
                                            returnData.data![i][element].toString(),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        } else {
                                          return const Text('');
                                        }
                                      })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [returnData.data![i]["ContactId"] == null? Container():
                                deleteSelectedRef != null
                                    ? IconButton(
                                        onPressed: () async {
                                          bool confirmed = await ConfirmDialog.show(
                                              title:
                                                  'Are you Sure to delete the record?');
                        
                                          if (confirmed) {
                                            deleteSelectedRef!(returnData.data![i]);
                                          }
                                        },
                                        icon: const Icon(Icons.delete))
                                    : Container(),
                                IconButton(
                                    onPressed: () {
                                      returnSelectedRef(returnData.data![i]);
                                    },
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
            toAdd.add(const SizedBox(
              width: 10,
            ));
          }

          addNew != null
              ? toAdd.add(Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        addNew!();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                      child: const Icon(
                        Icons.add,
                      )),
                ))
              : Container();

          Widget toReturnWidget = Column(
            children: [
              SelectableText('${returnData.data!.length} ShareHolder/Director${returnData.data!.length > 1 ? 's':''} hold ${returnData.data![0]["TtlShareHolding"]}/100% of Company Shares'),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: 230,
                  animation: true,
                  lineHeight: 15.0,
                  animationDuration: 1500,
                  percent: returnData.data![0]["TtlShareHolding"]/100,
                  //barRadius: const Radius.circular(20),
                  progressColor: Colors.yellow,
                ),
              Container(
                padding: const EdgeInsets.all(30),
                // color: Colors.red,
                child: SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 5.0,
                    spacing: 5.0,
                    children: toAdd,
                  ),
                ),
              ),
            ],
          );

          return toReturnWidget;
        },
        value: value,
      ),
    );
  }
}
