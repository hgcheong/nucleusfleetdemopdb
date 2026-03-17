import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';

const int wid=502;

@RoutePage()
class CustEnrollMemberAddress extends StatelessWidget {
  const CustEnrollMemberAddress(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam('contactId') this.contactId,
         @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? custEttyId;
  final String? mbrEttyId;
  final String? contactId;
  final String? addrId;
  final String? addrType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    // return Center(
    //   child: CustEnrollAddressForm(custEttyId: custEttyId, contactId: contactId, addrType: addrType),
    // );
    final query = QueryObject(
        querysql: '/sp/ApiEnrlAddr/queryasync',
        params: {
          "EttyId": mbrEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
    var querySave = 'ApiEnrlAddrSave';

    return SingleChildScrollView(
      child: AcxAddressForm(
        ettyId: mbrEttyId,
        contactId: contactId,
        addrType: addrType,
        query: query,
        querySaveSql: querySave,
        backToListUrl:
            '/custenroll/member/$custEttyId/detail/$mbrEttyId/address',
      ),
    );
  }
}
