import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=714;

@RoutePage()
class MchtMgmtLocationProfileAddress extends StatelessWidget {
  const MchtMgmtLocationProfileAddress(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam('contactId') this.contactId,
             @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? mchtEttyId;
  final String? locEttyId;
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
          "EttyId": locEttyId,
         "ContactId": convStrNewOrNullToNull(contactId),
              "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
     var querySave = 'ApiMgmtAddrSave';

    return SingleChildScrollView(
      child: AcxAddressForm(
        ettyId: locEttyId,
        contactId: contactId,
        addrType: addrType,
        query: query,
        querySaveSql: querySave,
        backToListUrl:
            '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/address',
      ),
    );
  }
}
