import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
import 'package:nucleusv2/src/core/components/shared/acx_S3_Button.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/components/acx_plugridextdatas3_provider.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_s3.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=665;

@RoutePage()
class MchtEnrlDocAppl extends HookConsumerWidget {
  const MchtEnrlDocAppl(
      {super.key, this.ettyId, this.moduleName, this.rpstryType});

  final String? rpstryType;
  final String? ettyId;
  final String? moduleName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return DocList(
      ettyId: ettyId,
      moduleName: moduleName,
      rpstryType: rpstryType,
    );
  }
}

class DocList extends HookConsumerWidget {
  const DocList({
    super.key,
    @PathParam.inherit('mchtEttyId') this.ettyId,
    this.moduleName,
    this.rpstryType,
  });

  final String? ettyId;
  final String? moduleName;
  final String? rpstryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    if (rpstryType == null || moduleName == null) {
      return const Center(
        child: SelectableText('No Uploads found'),
      );
    }
    final query = QueryObject(
        querysql: '/s3/list',
        params: {"EttyId": "$ettyId/$rpstryType", "ModuleName": moduleName},
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    final langKeyPair = [
      Langkeypair(keyVal: 'lastModified', fieldNm: 'Upload Date'),
      Langkeypair(keyVal: 'size', fieldNm: 'Size(Kb)'),
      Langkeypair(keyVal: 'key', fieldNm: 'Path'),
    ];

    return formData.when(
      data: (d) {
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                AcxAuditLogReqBtn('S3Download,S3Upload,S3Delete', ettyId: ettyId.toString(),),
                  S3UploadButton(
                      moduleName: moduleName,
                      ettyId: ettyId,
                      rpstryType: rpstryType,
                      query: query, logId: ettyId.toString(), wid: wid),
                  sbw10,
                  S3DownloadButton(query: query, logId: ettyId.toString(), wid: wid),
                  sbw10,
                  S3DeleteButton(query: query, logId: ettyId.toString(), wid: wid),
                  sbw20
                ],
              ),
            ),
            Flexible(
              flex: 12,
              child: SingleChildScrollView(
                child: AcxTrinaGridExtDataS3(
                  langClmName: langKeyPair,
                  extData: d,
                  useCheckBox: false,
                  onNew: () async {
                      if (isPageDeniedAction(AcxAuthAccess.actionDeniedList, wid)) {
                                  Toast.message("Action Not Authorised");
                                  return;
                                }
                    final res = await ApiService().postUpload(
                      '/s3/upload/$moduleName/$ettyId/$rpstryType?logId=${convStrNewOrNullToNull(ettyId) ?? 0}',
                      params: {},
                    );
                    Debugger.log(res.toString());
                  },
                  onRowDoubleTap: (TrinaRow v) async {
                    await downloadfile(
                        context, "${v.cells['key']!.value}", ref, query,ettyId.toString());
                  },
                  onSelectedTap: (TrinaRow v) {
                    ref.read(s3SelectedRowProvider.notifier).state =
                        "${v.cells['key']!.value}";
                  },
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString()),),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
