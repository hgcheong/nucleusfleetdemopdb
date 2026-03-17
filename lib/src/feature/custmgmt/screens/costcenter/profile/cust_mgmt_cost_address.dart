import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=555;

@RoutePage()
class CustMgmtCostAddress extends ConsumerWidget {
  const CustMgmtCostAddress(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('costCtrEttyId') this.costCtrEttyId,
      @PathParam('contactId') this.contactId,
         @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? custEttyId;
  final String? costCtrEttyId;
  final String? contactId;
   final String? addrId;
  final String? addrType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    // return Center(
    //   child: CustMgmtAddressForm(custEttyId: custEttyId, contactId: contactId, addrType: addrType),
    // );

    final query = QueryObject(
        querysql: '/sp/ApiMgmtAddr/queryasync',
        params: {
          "EttyId": costCtrEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
              "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
    var querySave = 'ApiMgmtAddrSave';
    return SingleChildScrollView(
        child: AcxAddressForm(
      ettyId: costCtrEttyId,
      contactId: contactId,
      addrType: addrType,
      query: query,
      querySaveSql: querySave,
      backToListUrl:
          '/custmgmt/costcen/$custEttyId/profile/$costCtrEttyId/address',
    ));

    // return SingleChildScrollView(
    //   child: AcxAddressForm(
    //     ettyId: cmpyEttyId,
    //     contactId: contactId,
    //     addrType: addrType,
    //     query: query,
    //     querySaveSql: querySave,
    //     backToListUrl: '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/address',
    //   ),
    // );
  }
}

///custmgmt/cmpy/16/detail/84/profile/geninfo
///
///custmgmt/cmpy/16/detail/84/profile/address
