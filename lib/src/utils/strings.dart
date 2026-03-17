import 'package:intl/intl.dart';

String normalizePhoneNumber(String phoneNumber) {
  if (!phoneNumber.startsWith("+")) {
    phoneNumber = "+$phoneNumber";
  }

  phoneNumber.replaceAll("-", "");
  phoneNumber.replaceAll(" ", "");

  return phoneNumber;
}

String fmtDateStr(String date) {
  final toProcessdate = DateTime.parse(date);

  return DateFormat.yMMMEd().format(toProcessdate);
}

String fmtDateStrShort(String date) {
  final toProcessdate = DateTime.parse(date);

  return DateFormat('yMMMEd').format(toProcessdate);
}

String fmtDateStrLong(String date) {
  final toProcessdate = DateTime.parse(date);

  return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(toProcessdate);
}



String regexLongtituteStr(String longitude) {
  final regex = RegExp(r'^-?((1[0-7][0-9]|[1-9]?[0-9])(\.\d{1,6})?|180(\.0{1,6})?)$');
  if (regex.hasMatch(longitude)) {
    return longitude;
  } else {
    return '';
  }
}

String regexLatitudeStr(String latitude) {
  final regex = RegExp(r'^-?([1-8]?[0-9](\.\d{1,6})?|90(\.0{1,6})?)$');
  if (regex.hasMatch(latitude)) {
    return latitude;
  } else {
    return '';
  }
}


