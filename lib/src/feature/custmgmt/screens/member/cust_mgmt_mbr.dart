import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app/acx_returndata_provider.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatacheckbox.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';

const int wid=330;

@RoutePage()
class CustMgmtMember extends ConsumerWidget {
  const CustMgmtMember({super.key, this.custEttyId});

  final String? custEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final listData = ref.watch(ReturndatafreezedProvider(QueryObject(
        querysql: '/sp/ApiMgmtMbrList/queryasync',
        params: {
          "CustEttyId": custEttyId,
        },
        showMsg: false)));

    return AsyncValueWidget(
        value: listData,
        data: (dv) {
          final theWidget = AcxTrinaGridExtDataCheckBox(
            extData: dv,
            spName: 'ApiMgmtMbrList',
          );
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    final allCheckItem = theWidget.checkedItem.value;
                    if (allCheckItem.isNotEmpty) {
                      allCheckItem.map((e) {
                        e.cells.forEach((key, value) {});
                      });
                    }
                  },
                  child: const SelectableText('Test')),
              theWidget
            ],
          );
        });
  }
}
