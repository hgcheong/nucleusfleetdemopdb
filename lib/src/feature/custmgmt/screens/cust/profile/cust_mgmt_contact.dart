import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';

// {
//   "EttyId": 8,
//   "ContactId": 5,
//   "ContactType": "PIC"
// }

const int wid=598;

@RoutePage()
class CustMgmtContact extends StatelessWidget {
  const CustMgmtContact(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('contactType') this.contactType});

  final String? custEttyId;
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
          "EttyId": custEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "ContactType": contactType
        },
        showMsg: false);
    const querySave = 'ApiMgmtContactSave';

    return AcxContactForm(
      isShowResendEmail: true,
      ettyId: custEttyId,
      contactId: contactId,
      contactType: contactType,
      query: query,
      querySaveSql: querySave,
      backToListUrl: '/custmgmt/cust/$custEttyId/profile/contact',
    );
  }
}
