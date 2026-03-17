import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';

const int wid=764;

@RoutePage()
class PrgCustMediaMTypeLanding extends ConsumerWidget {
  const PrgCustMediaMTypeLanding(
      {super.key, @PathParam.inherit('prgEttyId') this.prgEttyId});

  final String? prgEttyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    return const AutoRouter();
  }
}
