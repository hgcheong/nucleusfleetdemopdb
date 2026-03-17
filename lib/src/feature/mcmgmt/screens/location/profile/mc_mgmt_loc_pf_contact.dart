import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=717;

@RoutePage()
class MchtMgmtLocationProfileContact extends StatelessWidget {
  const MchtMgmtLocationProfileContact(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('contactType') this.contactType});

  final String? mchtEttyId;
  final String? locEttyId;
  final String? contactId;
  final String? contactType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final query = QueryObject(
        querysql: '/sp/ApiMgmtContact/queryasync',
        params: {
          "EttyId": locEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "ContactType": contactType
        },
        showMsg: false);
    const querySave = 'ApiMgmtContactSave';

    return AcxContactForm(
      ettyId: locEttyId,
      contactId: contactId,
      contactType: contactType,
      query: query,
      querySaveSql: querySave,
      backToListUrl:
          '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/contact',
    );
  }
}
