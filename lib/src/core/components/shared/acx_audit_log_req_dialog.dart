import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/core_imports.dart';


class AcxAuditLogReqDialog extends ConsumerWidget {
  const AcxAuditLogReqDialog(this.spName,this.ettyId, this.id, this.user, this.date, this.time, {super.key});

  final String? spName;
  final String? ettyId;
  final String? id;
  final String? user;
  final String? date;
  final String? time;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

         final queryqo = QueryObject(querysql: 'ApiLogReqListChgGetById', params: {
                       "SpName": spName,
                       "EttyId": ettyId == "null" || ettyId == "new" ? "0":ettyId,
                       "Id": id
                    }, showMsg: false);
                    final qryDtl = ref.watch(ReturndatafreezedProvider(queryqo));
                  return AsyncValueWidget(value: qryDtl, data: (theData){

                        return SingleChildScrollView(
                          child: SizedBox(
                           height: MediaQuery.of(context).size.height *1.5,
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                  children: [
                                    Expanded(child: IconButton(onPressed: (){
                                        context.maybePop();
                                    }, icon: Icon(Icons.close))),
                                  ],
                                )),
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                  children: [
                                    Expanded(child: Text('Audit Log Details')),
                                  ],
                                )),
                                Flexible(
                                  flex:1,  child:Row(children: [
  Expanded(child: Text("Date: ${date ?? ''}")),  Expanded(child: Text("Time: ${time ?? ''}")),

                                  ],)),
                                       Flexible(
                                  flex:1,  child:Row(children: [
  Expanded(child: Text("User: ${user ?? ''}")),  Expanded(child: Text("Id: ${id ?? ''}")),

                                  ],)),
                                  Divider(),
                                Flexible(
                                  flex: 10,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: 1280,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                           final theD = theData.data![index];
                                          if(theD['field'].toString().toUpperCase().contains("MDFDATE")  ){
                                          return Container();
                                        }
                                       return Divider();
                                      },
                                      itemCount: theData.rowcount!,
                                      itemBuilder: (context, index) {
                                        final theD = theData.data![index];
                                        if(theD['field'].toString().toUpperCase().contains("MDFDATE")){
                                          return Container();
                                        }
                                      if(spName!.toUpperCase().endsWith("DEL")){
  return ListTile(
                                      subtitle: Row(children: [
                                        Expanded(child: Text('Deleted Value: ${theD['newValue']?? ""}'))
                                      ],),
                                      title: Text('${theD['field']}'));
                                      }
                                      else{
  return ListTile(
                                      subtitle: Row(children: [
                                        Expanded(child: Text('Old Value: ${theD['oldValue']?? ""}')),
                                        Expanded(child: Text('New Value: ${theD['newValue']?? ""}'))
                                      ],),
                                      title: Text('${theD['field']}'));
                                      }
                                   
                                    },)
                                                          ),
                                ),
                              ],
                            ),
                          ));
                        
                  });
  }
}

