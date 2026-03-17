import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/components/acx_audit_log_req_btn.dart';
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
import '../../core/components/shared/acx_s3_button.dart';

const int wid=881;

@RoutePage()
class CClickCmsUpload extends HookConsumerWidget {
  const CClickCmsUpload({super.key});

  final String? rpstryType="img";
  final String? ettyId="landing";
  final String? moduleName="cclickcms";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User can upload pictures here for display in the cClick Customer Portal'),
        Expanded(child: DocList()),
      ],
    );
  }
}

class DocList extends HookConsumerWidget {
  const DocList({
    super.key
  });

  final String? rpstryType="img";
  final String? ettyId="landing";
  final String? moduleName="cclickcms";
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
      Langkeypair(keyVal: 'key', fieldNm: 'Path'),
      Langkeypair(keyVal: 'lastModified', fieldNm: 'Upload Date'),
      Langkeypair(keyVal: 'size', fieldNm: 'Size(Kb)'),
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
                      query: query, logId: ettyId.toString(),wid: wid,),
                  sbw10,
                  S3DownloadButton(query: query, logId: ettyId.toString(),wid: wid,),
                  sbw10,
                  S3DeleteButton(query: query, logId: ettyId.toString(),wid: wid,),
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
                        context, "${v.cells['key']!.value}", ref, query, ettyId.toString());
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
