import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/shared/acx_address_form.dart';
import 'package:nucleusv2/src/core/models/query_object_freezed.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

const int wid=447;

@RoutePage()
class CustEnrollCostAddress extends ConsumerWidget {
  const CustEnrollCostAddress(
      {super.key,
      @PathParam.inherit('custEttyId') this.custEttyId,
      @PathParam.inherit('costCtrEttyId') this.costCtrEttyId,
      @PathParam('contactId') this.contactId,
       @PathParam('addrId') this.addrId,
      @PathParam('addrType') this.addrType});

  final String? custEttyId;
  final String? costCtrEttyId;
  final String? contactId;
  final String? addrId;
  final String? addrType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }

    final query = QueryObject(
        querysql: '/sp/ApiEnrlAddr/queryasync',
        params: {
          "EttyId": costCtrEttyId,
          "ContactId": convStrNewOrNullToNull(contactId),
          "AddrId":convStrNewOrNullToNull(addrId),
          "AddrType": addrType
        },
        showMsg: false);
 var querySave = 'ApiEnrlAddrSave';

    return SingleChildScrollView(
        child: AcxAddressForm(
      ettyId: costCtrEttyId,
      contactId: contactId,
      addrType: addrType,
      query: query,
      querySaveSql: querySave,
      backToListUrl:
          '/custenroll/costcen/$custEttyId/profile/$costCtrEttyId/address',
    ));
  }
}

///custenroll/cmpy/16/detail/84/profile/geninfo
///
///custenroll/cmpy/16/detail/84/profile/address
