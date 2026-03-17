import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/components/acx_app_title.dart';
import 'package:nucleusv2/src/core/core_imports.dart';
import 'package:nucleusv2/src/core/menu_controller.dart';
import 'package:nucleusv2/src/utils/utils_import.dart';

AsyncValue<Returndata> getAppBarTitle(
    WidgetRef ref, Map<String, dynamic> params) {
  final queryTitle = QueryObject(
      querysql: '/sp/ConstructPgTitle/queryasync',
      params: params,
      showMsg: false);
  final queryForm = ref.watch(ReturndatafreezedProvider(queryTitle));
  return queryForm;
}

void setTitle(String title, WidgetRef ref){
     Future.delayed(const Duration(seconds: 1), () {
//       if(!title.isNullOrEmpty){
//  ref.read(appBarTitleProvider.notifier).state = title;
//       }
    });
}

Future<String?> getTitle(
    WidgetRef ref, Map<String, dynamic> params, AppBarTitleType theType) async {
  String spName = '';
  switch (theType) {
    case AppBarTitleType.enroll:
      spName = '/sp/ConstructEnrlPgTitle/queryasync';
      break;
    case AppBarTitleType.management:
      spName = '/sp/ConstructPgTitle/queryasync';
      break;
    // default:
    //       spName =  '/sp/ConstructEnrlPgTitle/queryasync';
  }
  params.forEach((k, v) {
    if (v == 'new' || v == 'null') {
      params[k] = null;
    }
  });
  final queryTitle =
      QueryObject(querysql: spName, params: params, showMsg: false);
  final queryForm =
      await ref.watch(ReturndatafreezedProvider(queryTitle).future);
  final theTitle = getOutputValueStr(queryForm.output, "@Title");
  return theTitle;
}

bool isAllowed(String pageName, String userName) {
  return true;
}

enum AppBarTitleType { enroll, management }

AsyncValueWidget<Returndata> appTitleWidget(
    WidgetRef ref, Map<String, dynamic> params, Widget body) {
  final queryTitle = getAppBarTitle(ref, params);
  return AsyncValueWidget(
      value: queryTitle,
      data: (theData) {
        if (theData.output != null) {
          final theTitle = getOutputValueStr(theData.output, "@Title");
          return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false, centerTitle: false,
                  title: AcxAppTitle(
                    pageTitle: theTitle.toString(),
                  )),
              body: body);
        } else {
          return const SelectableText('Error');
        }
      });
}

AsyncValueWidget<Returndata> appTitleRefWidget(
    WidgetRef ref, Map<String, dynamic> params, Widget body) {
  final queryTitle = getAppBarTitle(ref, params);
  return AsyncValueWidget(
      value: queryTitle,
      data: (theData) {
        if (theData.output != null) {
          final theTitle = getOutputValueStr(theData.output, "@Title");
          ref.read(appBarTitleProvider.notifier).state = theTitle.toString();
          return body;
          // return Scaffold(
          //     appBar: AppBar(
          //         title: AcxAppTitle(
          //       pageTitle: theTitle.toString(),
          //     )),
          //     body: body);
        } else {
          return const SelectableText('Error');
        }
      });
}

void clearTitle(WidgetRef ref) {
  //ref.read(appBarTitleProvider.notifier).state = "";
}
