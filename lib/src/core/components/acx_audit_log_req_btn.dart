import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/shared/acx_audit_log_req_list.dart';

class AcxAuditLogReqBtn extends HookConsumerWidget {
  const AcxAuditLogReqBtn(this.spName, {super.key,this.ettyId = "0",});

  final String spName;
  final String ettyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   return  Tooltip(
    message: 'Audit Log',
     child: ElevatedButton(
      child:  SizedBox(width: 30, child: Icon(Icons.history)),
      onPressed: ()async {
       await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: AcxAuditLogReqList(spName: spName, ettyId: ettyId,)
                                
                          );
                        },
                      );
                            }),
   );
  }
} 