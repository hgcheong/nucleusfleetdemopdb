import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:nucleusv2/src/core/components/acx_plugridextdatas3_provider.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_s3.dart';
import 'package:nucleusv2/src/core/components/shared/acx_s3_button.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=885;

class ReleaseNote extends HookConsumerWidget {
  const ReleaseNote({super.key, this.moduleName, this.rpstryType});

  final String? rpstryType;
  final String? moduleName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 
    return  DocList(
      moduleName: moduleName,
      rpstryType: rpstryType,
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
                  Text("$moduleName/$rpstryType"),

                  IconButton(
                      onPressed: () {
                        ref.invalidate(ReturndatafreezedProvider(query));
                      },
                      icon: const Icon(Icons.refresh)),
                      sbw10,
                      singleton<Storage>().getString('login_email') == logSPUserName ? ElevatedButton(
            onPressed: () async {
              ref.read(s3LoadingProvider.notifier).state = true;
              try {
  // /api/s3/PUKAL/OUTBOUND/2025/10
                await ApiService().postUploadMulti(
                  '/s3/$moduleName/$rpstryType',
                  params: {},
                );
              } catch (ex) {
                ref.read(s3LoadingProvider.notifier).state = false;
                Toast.error(ex.toString());
              } finally {
                if (context.mounted) {
                  ref.read(s3LoadingProvider.notifier).state = false;
                }
              }
              ref.invalidate(ReturndatafreezedProvider(query));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.upload),
                SelectableText('Upload'),
              ],
            )) : Container(),
                  S3DownloadButton(query: query, logId: rpstryType.toString(), wid: wid),
                  sbw10,
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
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
                  onRowDoubleTap: (TrinaRow v) async {
                    await downloadfile(
                        context, "${v.cells['key']!.value}", ref, query,rpstryType.toString() );
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



//  PukalFileS3Src(
//                                 moduleName: "ReleaseNote",
//                                 rpstryType: "Nucleus",
//                               ),