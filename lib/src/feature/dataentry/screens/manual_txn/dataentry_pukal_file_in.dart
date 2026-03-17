import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

const int wid=350;

@RoutePage()
class DataEntryPukalFileIn extends HookConsumerWidget {
  const DataEntryPukalFileIn({super.key, this.moduleName, this.rpstryType});

  final String? rpstryType;
  final String? moduleName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const DocList(
      moduleName: "Pukal",
      rpstryType: "Inbound",
    );
  }
}

class DocList extends HookConsumerWidget {
  const DocList({
    super.key,
    this.moduleName,
    this.rpstryType,
  });

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
        params: {"EttyId": "$rpstryType", "ModuleName": moduleName},
        showMsg: false);

    final formData = ref.watch(ReturndatafreezedProvider(query));

    final langKeyPair = [
      Langkeypair(keyVal: 'key', fieldNm: 'File Name'),
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
                  IconButton(
                      onPressed: () {
                        ref.invalidate(ReturndatafreezedProvider(query));
                      },
                      icon: const Icon(Icons.refresh)),
                  S3DeleteButton(query: query, logId: rpstryType.toString(), wid: wid),
                  S3DownloadButton(query: query, logId: rpstryType.toString(), wid: wid),
                  sbw10
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
                      '/s3/upload/$moduleName/$rpstryType',
                      params: {},
                    );
                    Debugger.log(res.toString());
                  },
                  onRowDoubleTap: (TrinaRow v) async {
                    await downloadfile(
                        context, "${v.cells['key']!.value}", ref, query,rpstryType.toString());
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
