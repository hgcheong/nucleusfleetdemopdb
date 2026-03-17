import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/utils/auth_helpers.dart';
import 'package:nucleusv2/src/utils/helpers.dart';

void showReport(String rptname, String params) {
  var toSend = EncryptHelpers.authEnc().encrypt('report=$rptname&$params');
  var rptData = toSend.base64;
  var urlEncoded = Uri.encodeComponent(rptData.toString());
  final urlToPost = '${Env.ssrsBaseUrl}rpt=$urlEncoded';
  launchInBrowser(Uri.parse(urlToPost));
}
