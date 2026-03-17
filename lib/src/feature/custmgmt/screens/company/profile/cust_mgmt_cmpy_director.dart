import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_directorship_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=447;

@RoutePage()
class CustMgmtCmpyDirector extends ConsumerWidget {
  const CustMgmtCmpyDirector(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('cmpyEttyId') this.cmpyEttyId,
     @PathParam('indvdId') this.indvdId});

   final String? custEttyId;
  final String? cmpyEttyId;
  final String? indvdId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    final query = QueryObject(
        querysql: '/sp/ApiMgmtCmpyDirectorship/queryasync',
        params: {
          "EttyId": cmpyEttyId,
          "IndvdId": convStrNewOrNullToNull(indvdId),

        },
        showMsg: false);
var querySave = 'ApiMgmtCmpyDirectorshipSave';
    return SingleChildScrollView(
        child: AcxDirectorShipForm(
      ettyId: cmpyEttyId,
      indvdId: indvdId,
      query: query,
      querySaveSql: querySave,
      backToListUrl:
          '/custmgmt/cmpy/$custEttyId/detail/$cmpyEttyId/profile/director',
    ));
  }
}


