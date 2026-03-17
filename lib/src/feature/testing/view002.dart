import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=205;

@RoutePage()
class RowandColumn2 extends StatelessWidget {
  const RowandColumn2({super.key, required this.row, required this.column});

  final int row;
  final int column;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    List<Widget> toAdd = [];
    int noToAdd = row * column;
    for (var i = 0; i < noToAdd; i++) {
      toAdd.add(Card(
        child: Row(
          children: [
            const SelectableText('bye'),
            ElevatedButton(
                onPressed: () {
                  Toast.message(i.toString());
                },
                child: const SelectableText('Click here'))
          ],
        ),
      ));
    }
    return SizedBox(
      height: 1280,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.abc),
                onPressed: () {},
              )),
          Expanded(
            flex: 10,
            child: GridView.count(
              crossAxisCount: column,
              children: [...toAdd],
            ),
          ),
        ],
      ),
    );
  }
}
