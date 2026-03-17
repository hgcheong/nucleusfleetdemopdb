import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=736;

@RoutePage()
class MchtMgmtAddress extends StatelessWidget {
  const MchtMgmtAddress(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? mchtEttyId;
  final String? contactId;
  final String? addrId;
  final String? addrType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final query = QueryObject(
        querysql: '/sp/ApiMgmtAddr/queryasync',
        params: {
          "EttyId": mchtEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
    var querySave = 'ApiMgmtAddrSave';

    return SingleChildScrollView(
      child: AcxAddressForm(
        ettyId: mchtEttyId,
        contactId: contactId,
        addrType: addrType,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/mcmgmt/mcht/$mchtEttyId/profile/address',
      ),
    );
  }
}
