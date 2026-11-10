import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=235;

@RoutePage()
class SubsidymgmtRate extends StatelessWidget {
  const SubsidymgmtRate({
    super.key,
    @PathParam.inherit('subsId') this.subsId,
    @PathParam('subsRateId') this.subsRateId,
  });

  final String? subsId;
  final String? subsRateId;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return const Column(
      children: [],
    );
  }
}

class SubsidymgmtRateVehcList extends ConsumerWidget {
  const SubsidymgmtRateVehcList({super.key, this.subsId, this.switchValue});

  final String? subsId;
  final Map<String, dynamic>? switchValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final formKeySwitch = GlobalKey<FormBuilderState>();
    final query = QueryObject(
        querysql: '/sp/ApiPrgSubsPrdList/queryasync',
        params: {"SubsId": subsId},
        showMsg: false);
    Map<String, dynamic> switchValue = {};
    final listData = ref.watch(ReturndatafreezedProvider(query));

    return listData.when(
        data: (rValue) {
          var data = rValue.data;

          Set<String> theValue = <String>{};
          data!.asMap().entries.forEach((ele) {
            theValue.add(ele.value['PrdDscp'].toString());
          });

          var identifier = {};
          for (var item in theValue) {
            List<dynamic> toAdd = [];
            data.asMap().entries.forEach((ele) {
              if (ele.value['PrdDscp'].toString() == item) {
                toAdd.add(ele.value);
              }
            });
            identifier[item] = toAdd;
          }
          List<Widget> categoryItem = [];

          for (var val in identifier.entries) {
            List<Widget> rowItems = [];

            List<dynamic> toVV = val.value;
            for (var item in toVV) {
              switchValue[item['PrdCd']] = item['PrdSts'];
            }

            for (var item in toVV) {
              rowItems.add(Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FbField(child: FormBuilderSwitch(
                      initialValue: item['PrdSts'] == 'N' ? false : true,
                      name: item['PrdCd'],
                      title: SelectableText(item['PrdDscp']),
                      onChanged: (value) {
                        switchValue[item['PrdCd']] = value == false ? 'N' : 'Y';
                      },
                      valueTransformer: (value) {
                        return value == false ? 'N' : 'Y';
                      },
                    )),
                  )
                ],
              ));
            }

            categoryItem.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...rowItems],
            ));
          }

          ListView toReturn = ListView(
            children: categoryItem,
          );

          return FormBuilder(
            initialValue: switchValue,
            key: formKeySwitch,
            child: toReturn,
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()),);
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
