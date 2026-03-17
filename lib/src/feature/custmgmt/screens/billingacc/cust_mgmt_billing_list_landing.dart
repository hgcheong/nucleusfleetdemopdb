import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/components/acx_tabview.dart';

const int wid=306;

@RoutePage()
class CustMgmtBillingListLanding extends StatelessWidget {
  const CustMgmtBillingListLanding({super.key, @PathParam.inherit('custEttyId') this.custEttyId});
    final String? custEttyId;
 
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
        child: SizedBox(
          height: 1280,
          child: AcxTabView(
            routes: [CustMgmtBillingList()],
            tabs: [
              Tab(
                text: "Billing Account",
              ),
        
            ],
          ),
        ),
      
    );
  }

}
