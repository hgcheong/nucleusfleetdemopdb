import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_directorship_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=482;

@RoutePage()
class MchtEnrlDirector extends StatelessWidget {
  const MchtEnrlDirector(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
      @PathParam('indvdId') this.indvdId});

  final String? mchtEttyId;
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
          "EttyId": mchtEttyId,
          "IndvdId": convStrNewOrNullToNull(indvdId),
        },
        showMsg: false);

var querySave = 'ApiEnrlCmpyDirectorshipSave';
    return SingleChildScrollView(
      child: AcxDirectorShipForm(
        ettyId: mchtEttyId,
        indvdId: indvdId,
        query: query,
        querySaveSql: querySave,
        backToListUrl: '/mcenroll/mcht/$mchtEttyId/profile/director',
      ),
    );
  }
}
