
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/buttons.dart';
import 'package:nucleusv2/src/core/components/drawer_list_tile.dart';
import 'package:nucleusv2/src/core/models/accessmodel/accessmodel.dart';
import 'package:nucleusv2/src/core/models/langkeypair/langkeypair.dart';
import 'package:nucleusv2/src/core/models/returndata/column_info.dart';
import 'package:nucleusv2/src/core/models/returndata/message.dart';
import 'package:nucleusv2/src/core/models/returndata/output.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/utils/uiplutogridhelpers.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:trina_grid/trina_grid.dart';

class IconWithFunction {
  IconWithFunction({required this.icon, required this.func, this.tooltip='', this.iconText=''});
  final Icon icon;
  final String? tooltip;
  final String? iconText;
  final Function func;
}

class AppButtonWithFunction {
  AppButtonWithFunction({required this.btn, required this.func});
  final AppButton btn;
  final Function func;
}

String getDscpVal(String src, String keyField) {
  final sl = src.split(" ");
  final aab = sl.where((c) => c.toString().contains('#')).toList();
  final posA = aab.indexWhere((c) => c.toString() == keyField);

  for (var v in aab) {
    if (sl.indexOf(v) == 0) {
      sl[sl.indexOf(v)] = "";
    } else {
      sl[sl.indexOf(v)] = "|";
    }
  }

  return sl.join(' ').split('|')[posA];
}

String getlabelbykeyval(List<Langkeypair> fromlist, String keytofind) {
  String toReturn = '';
  toReturn = fromlist.isNotEmpty
      ? fromlist
          .singleWhere((element) => element.keyVal == keytofind)
          .fieldNm
          .toString()
      : '';
  return toReturn;
}

String getRSAEncryptedPWD(String pwd){
      var parser = RSAKeyParser();
    RSAPublicKey publicKey = parser.parse(
            "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt4k2LaAwRP7Yp+OwyQMdyHsK8IzOEm72sC+4wQuEp3KZNDuunw0EO5kUQafNBFDmzPAxgpS5UiuTrYdI1jtreha0vxEfEOKOrm36LVzg0NVPiovL9aIzHJOo3zZpjIDlUmYIt3TehwFErut4HbjbxhlcF+fyWqyQM+dRWochUje+C3XmqhEpsxzE9pw5lrVbb8aYLHWPqoQl9kS9kEPHBYVb531gGd9ic7OqUqVTJSL4wY9tEO6oBAleiXmDVAZ0mg+/oiKhhQBe4q+pqLoKrbXJIjq3hImBSDtjazNTK/EA7aNvm5Ssu0DFWu00zDwxOmTE8BfcVLcwv8p5vclQ1wIDAQAB\n-----END PUBLIC KEY-----")
        as RSAPublicKey;
    Encrypter encrypter;
    Encrypted encrypted;
    encrypter = Encrypter(
      RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP),
    );
    encrypted = encrypter.encrypt(pwd.toString());
    return  encrypted.base64;
}

//sanoke dataPOINT (102.647903 2.2072659)
String getLatLong(String point){
 var toReturn = point;
  if(toReturn.contains('POINT')){
   toReturn = toReturn.replaceAll('POINT (', '');
   toReturn = toReturn.replaceAll(')', '');
   toReturn = toReturn.split(' ').reversed.join(',');
  }
  return toReturn;
}
String spStr(String sp) {
  return sp.contains('/') ? sp : '/sp/$sp/queryasync';
}

Map<String, dynamic> convertForm(Returndata retData) {
  return convertFormValueToDisplay(
      retData.data![0] as Map<String, dynamic>, retData.columnInfo!);
}

String getFormReqLabel(String fieldName,  String title, List<ColumnInfo>? clmInfo){
String toReturnTitle  = title;
  //Need to handle case where src have the key but clmInfo data does not have the key

  if (clmInfo == null) {
    return toReturnTitle;
  }
  else{

    final isFound = clmInfo.where((element) => element.data!.toUpperCase() == fieldName.toUpperCase());
    if(isFound.isNotEmpty){
         if (isFound.first.isReq!){
          toReturnTitle = "$toReturnTitle*";
         }
    } 

  }
  return toReturnTitle;
}

TextStyle? getFormTextStyle(String fieldName, List<ColumnInfo>? clmInfo){

  //Need to handle case where src have the key but clmInfo data does not have the key

  if (clmInfo == null) {
    return null;
  }
  else{

    final isFound = clmInfo.where((element) => element.data!.toUpperCase() == fieldName.toUpperCase());
    if(isFound.isNotEmpty){
         if (isFound.first.isReq!){
            return const TextStyle(color: Colors.amber);
         }
    } 

  }
  return null;
}

bool isReqField(String fieldName, List<ColumnInfo>? clmInfo){
  bool isreq = false;
  //Need to handle case where src have the key but clmInfo data does not have the key

  if (clmInfo == null) {
    return isreq;
  }
  else{

    final isFound = clmInfo.where((element) => element.data!.toUpperCase() == fieldName.toUpperCase());
    if(isFound.isNotEmpty){
  
        return isFound.first.isReq!;
    } 

  }
  return isreq;
}
//We need to convert the source data from api to conform with the format from FormBuilder
Map<String, dynamic> convertFormValueToDisplay(
    Map<String, dynamic> src, List<ColumnInfo>? clmInfo) {
  if (clmInfo == null) {
    return src;
  }

  Map<String, dynamic> converted = src.map((key, value) {
    //Need to handle case where src have the key but clmInfo data does not have the key
    final isFound = clmInfo.where((element) => element.data == key);

    if (isFound.isEmpty) {
      return MapEntry(key, value);
    }
    if (clmInfo.where((element) => element.data == key).first.dataType ==
        'date') {
      if (value != null) {
        return MapEntry(key, DateTime.parse(value));
      }
    }

    if (clmInfo.where((element) => element.data == key).first.dataType ==
        'datetime') {
      if (value != null) {
        return MapEntry(key, DateTime.parse(value));
      }
    }

    if (clmInfo.where((element) => element.data == key).first.dataType ==
        'time') {
      if (value != null) {
        final curDate = DateTime.now();
        return MapEntry(
            key,
            DateTime(
                curDate.year,
                curDate.month,
                curDate.day,
                int.tryParse(value.toString().split(':').first) ?? 0,
                int.tryParse(value.toString().split(':')[1]) ?? 0));
      }
    }
//Changing logic below might effect the FbHiddentText and also FbHiddentInt
    if (value != null) {
      return MapEntry(key, value.toString());
    } else {
      return MapEntry(key, value);
    }
  });
  return converted;
}

//Make One Global
Map<String, dynamic> convertFormValueToSave(
    Map<String, dynamic> src, List<ColumnInfo>? clmInfo) {
  if (clmInfo == null) {
    Map<String, dynamic> convertedAuto = src.map((key, value) {
      if (value.runtimeType.toString() == 'date') {
        return MapEntry(
            key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
      }
      if (value.runtimeType.toString() == 'DateTime') {
        return MapEntry(
            key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
      }
      return MapEntry(key, value);
    });
    return convertedAuto;
  }

  Map<String, dynamic> converted = src.map((key, value) {
    //Need to handle case where src have the key but clmInfo data does not have the key
    final isFound = clmInfo.where((element) => element.data == key);

    if (isFound.isEmpty) {
      return MapEntry(key, value);
    }

    if (clmInfo.where((element) => element.data == key).first.dataType ==
        'date') {
      if (value != null) {
        if (value.runtimeType.toString() == 'date') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }
        //We need below even though column type is date it's found during runtime this can be DateTime because of widget
        if (value.runtimeType.toString() == 'DateTime') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }

        //We need to call toString() here because when compile for deployment it is minified and dont have access to the length method
        if (value.toString().length == 23) {
          return MapEntry(key, DateTime.parse(value).toString());
        } else {
          return MapEntry(key, parseDate(value));
        }
      }
    }

    if (clmInfo.where((element) => element.data == key).first.dataType ==
        'datetime') {
      if (value != null) {
        //Put in below just incase as above. dataType not matching with widget runtimType
        if (value.runtimeType.toString() == 'date') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }
        if (value.runtimeType.toString() == 'DateTime') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }

        if (value.toString().length == 23) {
          return MapEntry(key, DateTime.parse(value).toString());
        } else {
          //looking at value of Tue, Jan 19, 1988

          return MapEntry(key, parseDate(value));
        }
      }
    }
    if (value == "") {
      return MapEntry(key, null);
    }
    return MapEntry(key, value);
  });
  return converted;
}

String parseDate(String value) {
  var splitStrDate = value.split(',');
  splitStrDate.removeWhere((String c) => c.length == 3);
  var joinString = splitStrDate.join(",").trim();
  return DateFormat.yMMMd().parse(joinString).toString();
}

//Use the below to extract a new map from src for Delete in TrinaGrid
Map<String, dynamic> getMapParam(
    Map<String, dynamic> src, List<String> toFetch) {
  Map<String, dynamic> map = {
    for (var item in toFetch)
      item: src.entries
          .where((tocheck) {
            return tocheck.key == item;
          })
          .first
          .value
  };
  return map;
}

Map<String, dynamic> getMapTrinaCell(
    Map<String, TrinaCell> src, List<String> toFetch) {
  Map<String, dynamic> map = {
    for (var item in toFetch)
      item: src.entries
          .where((tocheck) {
            return tocheck.key == item;
          })
          .first
          .value
          .value
          .toString()
  };
  return map;
}

//Use to replace the default date value because on saving the format is different
Map<String, dynamic> convertFormDateValue(
    Map<String, dynamic> src, List<String> listStr) {
  Map<String, dynamic> converted = src.map((key, value) {
    if (listStr.any((element) => element == key)) {
      // if (value != null) {
      //   return MapEntry(key, DateFormat('yMMMEd').format(value).toString());
      // }

      if (value != null) {
        //Put in below just incase as above. dataType not matching with widget runtimType
        if (value.runtimeType.toString() == 'date') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }
        if (value.runtimeType.toString() == 'DateTime') {
          return MapEntry(
              key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value));
        }

        if (value.toString().length == 23) {
          return MapEntry(key, DateTime.parse(value).toString());
        } else {
          //looking at value of Tue, Jan 19, 1988

          return MapEntry(key, parseDate(value));
        }
      }
    }
    return MapEntry(key, value);
  });
  return converted;
}

//Use to replace the default date AND time value because on saving the format is different\
//Deprecated Will not used the following because we do a global change in convertFormValueToSave
// Map<String, dynamic> convertFormDateTimeValue(Map<String, dynamic> src, List<String> clmToConvert) {
//   Map<String, dynamic> converted = src.map((key, value) {
//     if (clmToConvert.any((element) => element == key)) {
//       if (value != null) {
//         if (value.runtimeType.toString() == 'String') {
//           return MapEntry(key, value);
//         } else {
//           return MapEntry(key, DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(value).toString());
//         }
//       }
//     }
//     return MapEntry(key, value);
//   });
//   return converted;
// }

//This is used for Day Option
Map<String, dynamic> convertIntNullValue(
    Map<String, dynamic> src, List<String> clmToConvert) {
  Map<String, dynamic> converted = src.map((key, value) {
    if (clmToConvert.any((element) => element == key)) {
      if (value == null) {
        return MapEntry(key, 0);
      }
    }
    return MapEntry(key, value);
  });
  return converted;
}

Map<String, dynamic> convertFormTrueFalseValue(
    Map<String, dynamic> src, List<String> clmToConvert) {
  Map<String, dynamic> converted = src.map((key, value) {
    if (clmToConvert.any((element) => element == key)) {
      if (value == null) {
        return MapEntry(key, false);
      }
      return MapEntry(key, value == 'N' ? false : true);
    }
    return MapEntry(key, value);
  });
  return converted;
}

List<FormBuilderFieldOption<String>> getOptions(
    List<dynamic> data, String keyfield, String descfield) {
  List<FormBuilderFieldOption<String>> toreturn = List.empty(growable: true);
  for (var element in data) {
    toreturn.add(FormBuilderFieldOption(
      value: element[keyfield].toString(),
      child: SelectableText(
        element[descfield].toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
  return toreturn;
}

List<FormBuilderChipOption<String>> getChipOptions(
    List<dynamic> data, String keyfield, String descfield,
    {Map<String, Icon> theIcon = const {}}) {
  List<FormBuilderChipOption<String>> toreturn = List.empty(growable: true);
  for (var element in data) {
    toreturn.add(FormBuilderChipOption(
      avatar: theIcon.containsKey(element[keyfield].toString()) == true
          ? theIcon[element[keyfield].toString()]
          : null,
      value: element[keyfield].toString(),
      child: SelectableText(
        element[descfield].toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
  return toreturn;
}

bool isSuccess(Message? passedin) {
  if (passedin!.msgSeverity == 0) {
    return true;
  }
  return false;
}

bool isValidFromToTime(dynamic fromtime, dynamic totime){
    if(fromtime!=null && totime!=null){
      if(fromtime == totime){
        return false;
      }
    }
    return true;
}

int? getOutputValue(List<Output>? passedin, String outputname) {
  return int.tryParse(passedin!
      .where((element) => element.parameter == outputname)
      .first
      .value
      .toString());
}

String? getOutputValueStr(List<Output>? passedin, String outputname) {
  return passedin!
      .where((element) => element.parameter == outputname)
      .first
      .value
      .toString();
}

String getAfterSavePath(
    BuildContext context, List<Output>? output, String outputParamName) {
  String theNewId = getOutputValue(output, outputParamName).toString();
  final currentPath = singleton<AppRouter>().currentPath;
  final splitStr = currentPath.split('/');
  splitStr.removeLast();
  splitStr.add(theNewId);
  return splitStr.join('/');
}

bool isNewId(String? toCheck) {
  if (toCheck.toString().toUpperCase() == 'NEW') {
    return true;
  }
  if (toCheck == null) {
    return true;
  }

  return false;
}

bool isValidLongitude(String value) {
 
 var val = double.tryParse(value);
 if (val == null) {
    return false;
  }
  if (val < -180 || val > 180) {
    return false;
  }
  return true;
}

bool isValidLatitude(String value) {
  var val = double.tryParse(value);
  if (val == null) {
    return false;
  }
  if (val < -90 || val > 90) {
    return false;
  }
  return true;
} 

List<DrawerListTile> getAccessDrawerListTile(
    List<DrawerListTile> src, List<Accessmodel> blockedList) {
  final myVal = blockedList.map((c) {
    return c.moduleId;
  }).toList();
  src.removeWhere((w) => myVal.contains(w.wid));
  return src;
}

List<DrawerListTile> getUserDrawerListTile(
    List<DrawerListTile> src, List<dynamic> toRemove) {
  toRemove.removeWhere((c) {
    return c["Allow"] == "Y";
  });
  final myVal = toRemove.map((c) {
    return c["SetupId"];
  }).toList();
  src.removeWhere((w) => myVal.contains(w.wid));
  return src;
}

bool isPageDeniedView(List<Accessmodel> deniedPageList, int wid){
  
  bool isDenied = false; 
 var isFound = deniedPageList.where((c){
    return c.moduleId == wid;
  });
  if(isFound.isNotEmpty){
    isDenied = true;
  }
  return isDenied;
}

bool isPageDeniedAction(List<Accessmodel> deniedActionList, int wid){
  bool isDenied = false;
 var isFound = deniedActionList.where((c){
    return c.moduleId == wid;
  });
  if(isFound.isNotEmpty){
    isDenied = true;
  }
  return isDenied;
}

bool isAllowTabAccess(List<Map<String, dynamic>> allowedTab, int wid) {
  final isExistWID = allowedTab.where((c) {
    return c['wid'] == wid;
  });
  if (isExistWID.isEmpty) {
    return false;
  }
  final userAllow = allowedTab.where((c) {
    return c['wid'] == wid && c['Allow'] == 'N';
  });
  return userAllow.isEmpty;
}

bool isAllowSave(List<Map<String, dynamic>> allowedTab, int wid) {
  final userAllow = allowedTab.where((c) {
    return c['wid'] == wid && c['Allow'] == 'R';
  });

  return userAllow.isEmpty;
}

List<Tab> getUserTabs(
    List<Map<String, dynamic>> srcTab, List<Map<String, dynamic>> userTabs) {
  List<Tab> toReturn = List.empty(growable: true);
  for (var element in srcTab) {
    final userT = userTabs.where((d) {
      return d['wid'] == element['wid'];
    });
    if (userT.isNotEmpty && userT.first['Allow'] == 'N') {
      toReturn.add(const Tab(text: '', height: 0));
    } else {
      toReturn.add(Tab(text: element['Dscp'].toString()));
    }
  }
  // print(srcTab);
  // print(userTabs);

  // srcTab.map((c){
  //     final userT = userTabs.where((d){
  //       return d['wid'] == c['wid'];
  //     });
  //     print(userT);
  //  //   toReturn.add(Tab(text: c['Dscp'].toString()));
  //     // if(userT.isNotEmpty){

  //     //     toReturn.add(const Tab(text: '',height: 0,));
  //     // }else{
  //     //   toReturn.add(Tab(text: c['Dscp'].toString()));

  //     // }
  //    });

  return toReturn;
}

String? convStrNewOrNullToNull(String? src) {
  //the Bleow is done because for Address List the Contact id is 0 and i need to pass it as 0
  // if (src == "0") {
  //   return null;
  // }


  if (src == 'null') {
    return null;
  }
  if (src == 'new') {
    return null;
  }
    if (src == '') {
    return null;
  }
  return src;
}

void onCheckAllMethod(TrinaGridOnRowCheckedEvent v, Returndata dv,
    ValueNotifier<Set<TrinaRow>> checkedItem) {
  if (v.isAll) {
    if (v.isChecked!) {
      if (dv.data != null) {
        final theD = dv;
        checkedItem.value.addAll(getRows(
            theD.data!, theD.columnInfo!, theD.columnInfo!.length, null));
      }
    } else {
      checkedItem.value.clear();
    }
  }
}

void oncheckmethod(TrinaRow? rw, ValueNotifier<Set<TrinaRow>> checkedItem) {
  if (rw!.checked!) {
    checkedItem.value.add(rw);
  } else {
    checkedItem.value.remove(rw);
  }
}
