import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/components/acx_plugridextdatas3_provider.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

class S3DownloadButton extends ConsumerWidget {
  const S3DownloadButton({
    super.key,
    //  required this.id,
    required this.query,
    required this.logId,
    required this.wid
  });

  // final String id;
  final QueryObject query;
  final String logId;
  final int wid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final id = ref.watch(s3SelectedRowProvider);
    final isLoadingv = ref.watch(s3LoadingProvider);
    //
    return Row(
      children: [
        isLoadingv == true
            ? SizedBox(
            width: 12,
            height: 12,
            // child: CircularProgressIndicator(
            //   color: Colors.white,
            // ),
               child: Container(),
          )
            : id == ''
                ? Container()
                : ElevatedButton(
                    onPressed: () async {
                      await downloadfile(context, id, ref, query, logId);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.download),
                        SelectableText('Download'),
                      ],
                    )),
      ],
    );
  }
}


Future downloadfile(
    BuildContext context, String id, WidgetRef ref, QueryObject query, String logId) async {
  ref.read(s3LoadingProvider.notifier).state = true;
  try {
    await ApiService().postDownload(
      '/s3/download?logId=${convStrNewOrNullToNull(logId)}',
      params: {'key': id},
    );
    Toast.message('Downloaded');
  } catch (ex) {
    Toast.error(ex.toString());
  } finally {
    if (context.mounted) {
      ref.read(s3LoadingProvider.notifier).state = false;
    }
  }

  ref.invalidate(ReturndatafreezedProvider(query));
}

class S3DeleteButton extends ConsumerWidget {
  const S3DeleteButton({
    super.key,
    // required this.id,
    required this.query,
    required this.logId,
    required this.wid
  });

  // final String id;
  final QueryObject query;
  final String logId;
  final int wid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final id = ref.watch(s3SelectedRowProvider);
    final isLoadingv = ref.watch(s3LoadingProvider);
    return isLoadingv == true
        ? SizedBox(
            width: 12,
            height: 12,
            // child: CircularProgressIndicator(
            //   color: Colors.white,
            // ),
               child: Container(),
          )
        : id == ''
            ? Container()
            : ElevatedButton(
                onPressed: () async {
                  bool confirmed = await ConfirmDialog.show(
                    title: "Delete?",
                    body: "Are you sure you want to Delete? [$id]",
                    destructive: true,
                    confirmText: "Yes",
                    cancelText: "Cancel",
                  );

                  if (!confirmed) {
                    return;
                  }

                  ref.read(s3LoadingProvider.notifier).state = true;
                  try {
                    await ApiService().postHttpS3Delete(
                      '/s3/delete?logId=${convStrNewOrNullToNull(logId)?? 0}',
                      params: {'key': id},
                    );
                    Toast.message('Deleted');
                    ref.read(s3SelectedRowProvider.notifier).state = '';
                  } catch (ex) {
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
                    Icon(Icons.delete),
                    SelectableText('Delete'),
                  ],
                ));
  }
}

class S3UploadButton extends ConsumerWidget {
  const S3UploadButton({
    super.key,
    required this.moduleName,
    required this.ettyId,
    required this.rpstryType,
    required this.query,
    required this.logId,
    required this.wid
  });

  final String? moduleName;
  final String? ettyId;
  final String? rpstryType;
  final QueryObject query;
  final String logId;
  final int wid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final isLoadingv = ref.watch(s3LoadingProvider);
    return isLoadingv == true
        ? const SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : ElevatedButton(
            onPressed: () async {
              ref.read(s3LoadingProvider.notifier).state = true;
              try {
  
                await ApiService().postUploadMulti(
                  '/s3/upload/$moduleName/$ettyId/$rpstryType?logId=${convStrNewOrNullToNull(logId) ?? 0}',
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
            ));
  }
}


final s3LoadingProvider = StateProvider<bool>((ref) {
  return false;
});