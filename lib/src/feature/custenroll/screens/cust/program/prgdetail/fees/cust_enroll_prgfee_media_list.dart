import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_listbuttonnav_wrap.dart';

const int wid=829;

@RoutePage()
class CustEnrollProgramFeeMediaList extends StatelessWidget {
  const CustEnrollProgramFeeMediaList(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('prgEttyId') this.prgEttyId,
      @PathParam.inherit('billingEttyType') this.billingEttyType});

  final String? prgEttyId;
  final String? custEttyId;
  final String? billingEttyType;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Flexible(flex:1, child:  SelectableText('Select a Media Type to configure')),
        Expanded(
          flex: 11,
          child: AcxListButtonNavWrap(
              keyField: 'MediaType',
              //  filterField: 'MediaTypeDscp',
              querysql: '/sp/ApiEnrlCustMediaTypeList/queryasync',
              params: {
                "CustEttyId": custEttyId,
                "PrgEttyId": prgEttyId,
              },
              displayfield: const ['MediaType', 'MediaTypeDscp'],
              returnSelectedRef: (val) async {
                {
                  singleton<AppRouter>().navigatePath(
                      '/custenroll/custprg/$custEttyId/$prgEttyId/$billingEttyType/fees/media/mediadtl/${val['MediaType']}');
                }
              }),
        ),
      ],
    );
  }
}
