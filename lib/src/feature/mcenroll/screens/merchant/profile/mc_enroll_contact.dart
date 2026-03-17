import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_contact_form.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=673;

@RoutePage()
class MchtEnrlContact extends StatelessWidget {
  const MchtEnrlContact(
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
        querysql: '/sp/ApiEnrlContact/queryasync',
        params: {
          "EttyId": mchtEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "ContactType": contactType
        },
        showMsg: false);
    var querySave = 'ApiEnrlContactSave';

    return SingleChildScrollView(
      child: AcxContactForm(
        ettyId: mchtEttyId,
        contactId: contactId,
        contactType: contactType,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/mcenroll/mcht/$mchtEttyId/profile/contact/',
      ),
    );
  }
}

///mcenroll/mcht/11/profile/contact
