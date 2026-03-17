import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=482;

@RoutePage()
class CustEnrollAddress extends StatelessWidget {
  const CustEnrollAddress(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? custEttyId;
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
          "EttyId": custEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
    var querySave = 'ApiEnrlAddrSave';

    return SingleChildScrollView(
      child: AcxAddressForm(
        ettyId: custEttyId,
        contactId: contactId,
        addrType: addrType,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/custenroll/cust/$custEttyId/profile/address',
      ),
    );
  }
}
