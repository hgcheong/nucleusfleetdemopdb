import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_actionitems.dart';
import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/feature/custmgmt/screens/billingacc/cclickmockdata.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=790;

@RoutePage()
class CustMgmtTxnRecentLanding extends StatelessWidget {
  const CustMgmtTxnRecentLanding({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
          sbh10,
          const SelectableText(
              "Posted Transactions are fully processed transactions. The transaction amount already reflected in the Account’s Current Balance and Available Credit"),
          sbh20,
          const SelectableText(
            "Transaction Search",
            //     style: hdrStyle,
          ),
          sbh10,
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FbLibViewExt(
                                inputIcon: const Icon(Icons.sell),
                                name: '',
                                label: 'Trans Type',
                                searchText: 'CmpyName',
                                keyField: 'UserId',
                                datasrc: dropDownViewStatement,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FbLibViewExt(
                                inputIcon: const Icon(Icons.store),
                                name: '',
                                label: 'Location',
                                searchText: 'CmpyName',
                                keyField: 'UserId',
                                datasrc: dropDownViewStatement,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person),
                            ),
                            sbw20,
                            Expanded(
                                child:
                                    FbText(label: 'Media No', name: 'media')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  sbw10,
                  Flexible(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          sbw10,
                          const Flexible(
                              child: FbDateTimePicker(
                                  name: 'From', label: 'From Date')),
                          fbFieldGap,
                          const Flexible(
                              child: FbDateTimePicker(
                                  name: 'ToDate', label: 'To Date')),
                          sbw20,
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.search))
                        ],
                      ),
                      const SizedBox(
                        height: 110,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 100,
                    child: Column(
                      children: [],
                    ),
                  ),
                  const Column(
                    children: [],
                  )
                ],
              ),
            ),
          ),
          const SelectableText(
            'Transactions',
            //     style: hdrStyle,
          ),
          // AcxTrinaGridExtData(
          //     extData: toUseTxnList,
          //     spName: 'ApiEnrlCustList',
          //     idField: 'UserId',
          //     navPrefix: '/custenroll/cust',
          //     onSelectedTap: (TrinaRow val) async {
          //       await showDialog(
          //         barrierDismissible: false,
          //         context: context,
          //         builder: (context) {
          //           //     return SelectableText('Goona show dialog too ');
          //           return Dialog(child: TransDetailForm(row: val));
          //         },
          //       );
          //     })
          AcxTrinaGridExtDataActionItems(
              showActions: true,
              extData: toUseTxnList,
              popMenuItems: const [
                {"value": "abc", "text": "cde"}
              ],
              spName: 'ApiEnrlCustList',
              idField: 'UserId',
              navPrefix: '/custenroll/cust',
              onSelectedTap: (TrinaRow val) {
                singleton<AppRouter>().navigatePath(
                    '/usermgmt/webportaluser/dtl/${val.cells['UserId']!.value.toString()}');
              })
        ]),
      ),
    );
  }
}

class TransDetailForm extends StatelessWidget {
  const TransDetailForm({super.key, required this.row});

  final TrinaRow row;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    var theVal = toUseTxnList.data!
        .where((c) => c['UserId'] == row.cells['UserId']!.value)
        .first;
    return SizedBox(
        width: 1024,
        height: 1280,
        child: Row(
          children: [
            Expanded(
              child: Card(
                  child: ListView(
                children: [
                  ListTile(
                    leading: const SelectableText(
                      'Transaction ID',
                      //    style: hdrStyle,
                    ),
                    title: SelectableText(theVal["TxnId"].toString()),
                  ),
                  ListTile(
                    leading: const SelectableText('Transaction Date'),
                    title: SelectableText(theVal["TxnDate"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Post Date'),
                    title: SelectableText(theVal["PostDate"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Media Number'),
                    title: SelectableText(theVal["MediaNumber"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Authorization Card'),
                    title: SelectableText(theVal["AuthCard"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Type of Transaction'),
                    title: SelectableText(theVal["TypeOfTran"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Description'),
                    title: SelectableText(theVal["Description"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Transaction Amount'),
                    title: SelectableText(
                      theVal["TxnAmount"],
                      textAlign: TextAlign.end,
                    ),
                  ),
                  ListTile(
                    leading: const SelectableText('Merchant ID'),
                    title: SelectableText(theVal["MerchantID"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('TID'),
                    title:
                        SelectableText(theVal["TID"], textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('STAN'),
                    trailing: SelectableText(theVal["STAN"],
                        textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('RRN'),
                    trailing:
                        SelectableText(theVal["RRN"], textAlign: TextAlign.end),
                  ),
                  ListTile(
                    leading: const SelectableText('Odometer Reading'),
                    trailing: SelectableText(theVal["Odometer"],
                        textAlign: TextAlign.end),
                  ),
                ],
              )),
            ),
            Expanded(
                child: Card(
                    child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SelectableText(
                        "Product",
                        //    style: hdrStyle,
                      ),
                      IconButton(
                          onPressed: () {
                            singleton<AppRouter>().maybePop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                AcxTrinaGridExtData(
                    extData: toUsePrdList,
                    spName: 'ApiEnrlCustList',
                    idField: 'UserId',
                    navPrefix: '/custenroll/cust',
                    onSelectedTap: (TrinaRow val) async {
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          //     return SelectableText('Goona show dialog too ');
                          return Dialog(child: TransDetailForm(row: val));
                        },
                      );
                    }),
              ],
            )))
          ],
        ));
  }
}
