import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

import 'package:flutter/material.dart';
import 'package:nucleusv2/constants.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdata_actionitems.dart';

import 'package:nucleusv2/src/core/components/formbuilder/fb_imports.dart';
import 'package:nucleusv2/src/feature/mcmgmt/screens/billingacc/cclickmockdata.dart';
import 'package:trina_grid/trina_grid.dart';

const int wid=706;

@RoutePage()
class MchtMgmtSettlementDetail extends StatelessWidget {
  const MchtMgmtSettlementDetail({super.key});

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return SingleChildScrollView(
      child: SizedBox(
        height: 1280,
        child: ListView(children: [
          const SelectableText(
            'View Statements',
            //   style: hdrStyle,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FbLibViewExt(
                      name: '',
                      label: 'Select Statements',
                      searchText: 'CmpyName',
                      keyField: 'UserId',
                      datasrc: dropDownViewStatement,
                    ),
                    sbh20,
                    SizedBox(
                      height: 400,
                      child: Card(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: const SelectableText(
                                'Current Statement',
                                //    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.download)),
                            ),
                            div,
                            const ListTile(
                              leading: SelectableText('Billing Account ID'),
                              title: SelectableText("12345678"),
                            ),
                            const ListTile(
                              leading: SelectableText('Statement Date'),
                              title: SelectableText("31 Aug 2023"),
                            ),
                            const ListTile(
                              leading: SelectableText('Statment Balance'),
                              title: SelectableText("12,345.00"),
                            ),
                            const ListTile(
                              leading: SelectableText('Due Date'),
                              title: SelectableText("20 Sep 2023"),
                            ),
                            const ListTile(
                              leading: SelectableText('Status'),
                              title: SelectableText("Open"),
                            ),
                            ListTile(
                                leading: const SelectableText(
                                  'Transactions',
                                  //       style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_drop_down),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
          sbh20,
          const SelectableText(
            'Transactions',
            //       style: hdrStyle,
          ),
          SingleChildScrollView(
            child: AcxTrinaGridExtDataActionItems(
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
                }),
          )
        ]),
      ),
    );
  }

  //   Flexible(
  //     flex: 8,
  //     child: Row(children: [Card(
  //       child: ListView(
  //         children: [
  //           ListTile(
  //             leading: const SelectableText(
  //               'Current Statement',
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //             ),
  //             trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
  //           ),
  //           div,
  //           const ListTile(
  //             leading: SelectableText('Billing Account ID'),
  //             title: SelectableText("12345678"),
  //           ),
  //           const ListTile(
  //             leading: SelectableText('Statement Date'),
  //             title: SelectableText("31 Aug 2023"),
  //           ),
  //           const ListTile(
  //             leading: SelectableText('Statment Balance'),
  //             title: SelectableText("12,345.00"),
  //           ),
  //           const ListTile(
  //             leading: SelectableText('Due Date'),
  //             title: SelectableText("20 Sep 2023"),
  //           ),
  //           const ListTile(
  //             leading: SelectableText('Status'),
  //             title: SelectableText("Open"),
  //           ),
  //           ListTile(
  //               leading: const SelectableText('Transactions', style: TextStyle(fontWeight: FontWeight.bold)),
  //               trailing: IconButton(
  //                 onPressed: () {},
  //                 icon: const Icon(Icons.arrow_drop_down),
  //               )),
  //         ],
  //       ),
  //     )],),
  //   )
}
