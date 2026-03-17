import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=739;

@RoutePage()
class MchtMgmtContact extends StatelessWidget {
  const MchtMgmtContact(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('contactType') this.contactType});

  final String? mchtEttyId;
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
         "EttyId": mchtEttyId,
        "ContactId": convStrNewOrNullToNull(contactId),
         "ContactType": contactType
        },
        showMsg: false);
    const querySave = 'ApiMgmtContactSave';

    return AcxContactForm(
        ettyId: mchtEttyId,
        contactId: contactId,
        contactType: contactType,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/mcmgmt/mcht/$mchtEttyId/profile/contact');
  }
}
