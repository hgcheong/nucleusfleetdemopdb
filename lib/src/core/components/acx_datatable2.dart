import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_acxdatatable.dart';
import 'package:nucleusv2/src/core/components/async_value_widget.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';

class AcxDataTable2 extends HookConsumerWidget {
  const AcxDataTable2(
      {super.key,
      this.showCheckBox = false,
      this.showActions = false,
      this.isMultiSelect = false,
      required this.querysql,
      required this.params,
      required this.onShowMessage});
  final bool showCheckBox;
  final bool showActions;
  final bool isMultiSelect;
  final String querysql;
  final Map<String, dynamic> params;
  final Function onShowMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerUrl =
        useTextEditingController(text: '/sp/ApiEnrlMchtList/queryasync');
    final controllerParam = useTextEditingController(text: '{}');
    final controlelrResult = useTextEditingController(text: '');
    // final theResult = useState<Returndata>(Returndata());
    final listValue = ref.watch(querySearchResultProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: controllerUrl,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 32),
                hintText: 'Query Search',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none),
          ),
          TextFormField(
            controller: controllerParam,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 32),
                hintText: 'Params',
                hintStyle: TextStyle(color: Colors.white)),
          ),
          TextFormField(
            maxLines: 5,
            controller: controlelrResult,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 32),
                hintText: 'Results',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none),
          ),
          ElevatedButton(
              onPressed: () async {}, child: const Text('Load Data')),
          ElevatedButton(
              onPressed: () async {
                //  ref.read(querySearchStateProvider.notifier).state = TheQueryObject(controllerUrl.text, json.decode(controllerParam.text));
                // theResult.value = await loadData(
                //     controllerUrl.text, json.decode(controllerParam.text));

                ref.invalidate(querySearchResultProvider);
              },
              child: const Text('Load Data AsyncValue')),
          listValue.value!.data == null
              ? Container()
              : AsyncValueWidget<Returndata>(
                  value: listValue,
                  data: (data) => data.data!.isEmpty
                      ? const Center(
                          child: Text('Not Found'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Text(data.data![index]["MchtName"]),
                                title: Text(data.data![index]["MchtStsDscp"]),
                                subtitle:
                                    Text(data.columnInfo![index].toString()));
                          },
                        ),
                )
        ],
      ),
    );
  }

  // loadData(String querysql, Map<String, dynamic> params) async {
  //   Returndata myData =
  //       await ApiAcxDataTableService(querysql, params).listDynamic();
  //   return myData;
  // }
}
