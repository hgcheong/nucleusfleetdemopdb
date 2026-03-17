import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_plutogridextdatawexport.dart';
import 'package:nucleusv2/src/feature/usermgmt/screens/user_mgmt_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:nucleusv2/src/core/core_imports.dart';

const int wid=267;

@RoutePage()
class UserMgmtWebPortalUserList extends ConsumerWidget {
  const UserMgmtWebPortalUserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   return UserRoleGridSearchSliver();
  }
}

class UserRoleGridSearchSliver extends ConsumerWidget {
  const UserRoleGridSearchSliver(
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    final userSearchFormKey = GlobalKey<FormBuilderState>();

    Map<String, dynamic> formNewValue = {
  "UserType": "E",
  "SignIn" : null,
  "Email":null
};
 return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(  title:  Text('User List'),
      automaticallyImplyLeading: false, centerTitle: false,
       
      ),
      //2
      SliverToBoxAdapter(child: Column(
        mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            FormBuilder(
              key: userSearchFormKey,
              initialValue: formNewValue,
              child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [         Expanded(child: FbHiddenText(name: 'UserType'),),],),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.account_box),
                      ),
                      sbw20,
                      const Expanded(
                        flex: 2,
                          child:
                              FbText(label: 'SignIn', name: 'SignIn')),   sbw10,
                        const Expanded(
                          flex:4 ,
                          child:
                              FbText(label: 'Email', name: 'Email')),  
                        Expanded(flex: 1,child:   IconButton(
                          onPressed: () {
                            userSearchFormKey.currentState!.save();
                            Map<String, dynamic> toPost =
                                    Map.from(userSearchFormKey.currentState!.value);    
                              if(toPost["Email"]== "" ) {
                                toPost["Email"] = null;
                              }

                               if(toPost["SignIn"]== "" ) {
                                   toPost["SignIn"] = null;
                              }
                            ref
                                .read(userRoleGridSearchControllerProvider.notifier)
                                .state = toPost;
                          },
                          icon:  const Icon(Icons.search)),) ,
                                       Expanded(flex: 1,child:   IconButton(
                          onPressed: () {
                               singleton<AppRouter>().navigatePath(
              '/usermgmt/webportaluser/dtl/new');
                          },
                          icon:  const Icon(Icons.add)),) ,   
                          
                    ],
                  ),
                ],
              ),
            ),
            //    const Spacer(flex: 4,)    
           // sbw10,
            // Expanded(
            //   flex: 1,
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //         ,
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
              ),
            )
          ]),),
     const SliverFillRemaining(child: UserRoleGridSearch(),)
    ],
  );

  }
}

class UserRoleGridSearch extends ConsumerWidget {
  const UserRoleGridSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

 if (isPageDeniedView(AcxAuthAccess.pageDeniedList, wid)) {
        return const NotAuthorised();
    }
    var toPost = ref.watch(userRoleGridSearchControllerProvider);
    if(toPost["SignIn"]==null && toPost["Email"]==null){
      return const Center(child:Text('No Data'));
    }
    final query = QueryObject(
        querysql: '/sp/ApiSignInRoleSearch/queryasync',
        params: toPost,
        showMsg: false);
    final data = ref.watch(ReturndatafreezedProvider(query));
    return AsyncValueWidget(
        value: data,
        data: (theData) {
          return AcxTrinaGridExtDatawExport(
              gridTitle: 'Sign In List',
              extData: theData,
              idField: 'SignIn',
              onNew: (){
                Toast.message("Add Nre");
              },
              onSelected: (TrinaRow val) async {
                   ref.read(userPortalControllerProvider.notifier).state = val.toJson();
                 //  print(val.toJson());
              singleton<AppRouter>().navigatePath(
              '/usermgmt/webportaluser/dtl/${val.cells['SignIn']!.value.toString()}');

              });
        });
  }
}
 
