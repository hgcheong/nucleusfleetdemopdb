import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_directorship_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=482;

@RoutePage()
class MchtMgmtLocationProfileDirector extends StatelessWidget {
  const MchtMgmtLocationProfileDirector(
      {super.key,
      @PathParam.inherit('mchtEttyId') this.mchtEttyId,
           @PathParam.inherit('locEttyId') this.locEttyId,
      @PathParam('indvdId') this.indvdId});

  final String? mchtEttyId;
final String? locEttyId;  
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
        querysql: '/sp/ApiMgmtCmpyDirectorship/queryasync',
        params: {
          "EttyId": locEttyId,
          "IndvdId": convStrNewOrNullToNull(indvdId),
        },
        showMsg: false);
var querySave = 'ApiMgmtCmpyDirectorshipSave';

    return SingleChildScrollView(
      child: AcxDirectorShipForm(
        ettyId: locEttyId,
        indvdId: indvdId,
        query: query,
        querySaveSql: querySave,
        backToListUrl:  '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/director'
        //     '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/director/directordtl/${val["IndvdId"]}');
        // '/mcmgmt/loc/$mchtEttyId/detail/$locEttyId/profile/contact',
      ),
    );
  }
}
