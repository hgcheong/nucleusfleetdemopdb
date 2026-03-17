import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_directorship_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=482;

@RoutePage()
class CustEnrollDirector extends StatelessWidget {
  const CustEnrollDirector(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam('indvdId') this.indvdId});

  final String? custEttyId;
  final String? indvdId;

  @override
  Widget build(BuildContext context) { 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
            return const NotAuthorised();
}
    // return Center(
    //   child: CustEnrollAddressForm(custEttyId: custEttyId, contactId: contactId, addrType: addrType),
    // );
    final query = QueryObject(
        querysql: '/sp/ApiEnrlCmpyDirectorship/queryasync',
        params: {
          "EttyId": custEttyId,
          "IndvdId": convStrNewOrNullToNull(indvdId),
        },
        showMsg: false);
  var querySave = 'ApiEnrlCmpyDirectorshipSave';

    return SingleChildScrollView(
      child: AcxDirectorShipForm(
        ettyId: custEttyId,
        indvdId: indvdId,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/custenroll/cust/$custEttyId/profile/director',
      ),
    );
  }
}
