import 'package:auto_route/auto_route.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';

final usermgmtTabRouter = CustomRoute(
    transitionsBuilder: defaultTrans,
    usesPathAsKey: true,
      duration: Duration(milliseconds: defaultTransTime),
    path: "/usermgmt",
    page: UserMgmtContainer.page,
    children: [
      AutoRoute(
          path: 'webgroup',
          page: UserMgmtWebGroupLanding.page,
          children: [
            AutoRoute(path: '', page: UserMgmtWebGroupList.page, initial: true),
            AutoRoute(
              path: 'dtl/:userGrp/:userType/:grpId',
              page: UserMgmtWebGroupDtl.page,
            ),
          ]),
      AutoRoute(
        path: 'nucleususer',
        page: UserMgmtNucleusUserLanding.page,
        children: [
          AutoRoute(
              path: '', page: UserMgmtNucleusUserList.page, initial: true),
          AutoRoute(path: 'dtl/:userId', page: UserMgmtNucleusUser.page),
          AutoRoute(
              path: 'accessrightslist/:userId',
              page: UserMgmtNucleusUserAccessList.page),
          AutoRoute(
              path: 'accessrightsadd/:userId',
              page: UserMgmtNucleusUserAccessAddGroup.page),
          AutoRoute(
              path: 'accessrights/:userId',
              page: UserMgmtNucleusUserAccessSettings.page),
          AutoRoute(
              path: 'status/:userId',
              page: UserMgmtNucleusUserChangeStatus.page),
        ],
      ),
      AutoRoute(
        path: 'webportaluser',
        page: UserMgmtWebPortalLanding.page,
        children: [
          AutoRoute(
              path: '', page: UserMgmtWebPortalUserList.page, initial: true, maintainState: false),
          AutoRoute(path: 'dtl/:userId', page: UserMgmtWebPortalUser.page, maintainState: false),
          AutoRoute(path: 'assign/:userId', page: UserMgmtWebPortalUserAssign.page, maintainState: false),
          AutoRoute(
              path: 'accessrightslist/:userId',
              page: UserMgmtWebPortalUserAccessList.page),
          AutoRoute(
              path: 'accessrightsadd/:userId',
              page: UserMgmtWebPortalUserAccessAddGroup.page),
          AutoRoute(
              path: 'accessrights/:userId',
              page: UserMgmtWebPortalUserAccessSettings.page),
          AutoRoute(
              path: 'status/:userId',
              page: UserMgmtWebPortalUserChangeStatus.page),
        ],
      ),
    ]);
