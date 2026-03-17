import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/components/acx_plugridextdatas3_provider.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';

class AcxTrinaGridExtDataS3 extends ConsumerWidget {
  const AcxTrinaGridExtDataS3({
    super.key,
    this.showCheckBox = false,
    this.showActions = false,
    this.isMultiSelect = false,
    this.useCheckBox = false,
    this.useNav = true,
    this.idField = '',
    this.navPrefix = '',
    this.gridLabel = '',
    required this.onSelectedTap,
    this.onRowDoubleTap,
    this.onChecked,
    this.onCheckedAll,
    this.onNew,
    required this.langClmName,
    required this.extData,
  });
  final bool showCheckBox;
  final bool showActions;
  final bool isMultiSelect;
  final bool useNav;
  final bool useCheckBox;
  final String idField;
  final String navPrefix;
  final String gridLabel;
  final Function onSelectedTap;
  final Function? onRowDoubleTap;
  final Function? onNew;
  final Function? onChecked;
  final Function? onCheckedAll;
  final Returndata extData;
  final List<Langkeypair> langClmName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        extData.data == null
            ? const SizedBox(
                height: 500,
              )
            : Card(
                child: SizedBox(
                    height: 1280,
                    child: buildDataTableExtS3(extData, getGridConfig(context),
                        idField, navPrefix, langClmName, useNav,
                        useCheckBox: useCheckBox,
                        onChecked: onChecked,
                        onCheckAll: onCheckedAll,
                        onSelected: onSelectedTap,
                        onRowDoubleTap: onRowDoubleTap))),
        //  child: Center(child: Text('on'))),
      ],
    );
  }
}

class DeleteButtonS3 extends ConsumerWidget {
  const DeleteButtonS3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String deleteId = ref.watch(s3SelectedRowProvider);
    return IconButton(
        onPressed: () async {
          try {
            Toast.message(deleteId);
            bool confirmed = await ConfirmDialog.show(
                title: 'Are you Sure to delete the file $deleteId');

            if (confirmed) {
              ApiService()
                  .postHttpReturnData('/s3/delete',
                      params: {'key': deleteId}, showMsg: true)
                  .then((value) {
                ref.read(s3ReloadProvider.notifier).state = DateTime.now();
              });
            }
          } catch (e) {
            Toast.error(e.toString());
          } finally {}
        },
        icon: const Icon(Icons.delete));
  }
}
