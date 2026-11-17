import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';

import 'adj_models.dart';

/// Paths for the approval module (see workflowmgmtTabRouter):
///   /workflowmgmt/<kind>                 queue
///   /workflowmgmt/<kind>/new             new request
///   /workflowmgmt/<kind>/view/<ref>      one request
/// where <kind> is `adjustment` or `bulkpayment`.
String adjPath(AdjKind kind) => '/workflowmgmt/${kind.path}';

void adjGoList(AdjKind kind) => singleton<AppRouter>().navigatePath(adjPath(kind));

void adjGoNew(AdjKind kind) => singleton<AppRouter>().navigatePath('${adjPath(kind)}/new');

void adjGoDetail(AdjRequest r) =>
    singleton<AppRouter>().navigatePath('${adjPath(r.kind)}/view/${r.referenceCode}');
