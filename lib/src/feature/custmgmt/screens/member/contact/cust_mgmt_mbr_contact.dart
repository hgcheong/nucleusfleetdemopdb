import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=619;

@RoutePage()
class CustMgmtMemberContact extends StatelessWidget {
  const CustMgmtMemberContact(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('mbrEttyId') this.mbrEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('contactType') this.contactType});

  final String? custEttyId;
  final String? mbrEttyId;
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
          "EttyId": mbrEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "ContactType": contactType
        },
        showMsg: false);
    const querySave = 'ApiMgmtContactSave';

    return AcxContactForm(
      ettyId: mbrEttyId,
      contactId: contactId,
      contactType: contactType,
      query: query,
      querySaveSql: querySave,
      backToListUrl: '/custmgmt/member/$custEttyId/detail/$mbrEttyId/contact',
    );
  }
}
