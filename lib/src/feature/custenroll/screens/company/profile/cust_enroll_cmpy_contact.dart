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

const int wid=450;

@RoutePage()
class CustEnrollCmpyContact extends StatelessWidget {
  const CustEnrollCmpyContact(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
      @PathParam('contactId') this.contactId,
      @PathParam('contactType') this.contactType});

  final String? custEttyId;
  final String? cmpyEttyId;
  final String? contactId;
  final String? contactType;
  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    final query = QueryObject(
        querysql: '/sp/ApiEnrlContact/queryasync',
        params: {
          "EttyId": cmpyEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "ContactType": contactType
        },
        showMsg: false);
    var querySave = 'ApiEnrlContactSave';

    return AcxContactForm(
      ettyId: cmpyEttyId,
      contactId: contactId,
      contactType: contactType,
      query: query,
      querySaveSql: querySave,
      backToListUrl:
          '/custenroll/cmpy/$custEttyId/detail/$cmpyEttyId/profile/contact',
    );
  }
}

///custenroll/cmpy/16/detail/84/profile/contact
