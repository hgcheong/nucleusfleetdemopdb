import 'dart:io';
import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:download/download.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/env.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:nucleusv2/src/core/models/returndata/multireturndata.dart';
import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/feature/auth/models/token.dart';
import 'package:nucleusv2/src/utils/toast.dart';
import 'dart:convert';

import 'package:web/web.dart' as web;

class ApiService {
  
  Map<String, dynamic> _headers([bool auth = true])
   {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      // HttpHeaders.acceptLanguageHeader: Locale.shortName,
      ...auth
          ? {'Authorization': "Bearer ${Token.fromStorage().access_token}"}
          : {}
    };
  }

  BaseOptions _options({bool auth = true}) {
    return BaseOptions(baseUrl: Env.apiBaseUrl, headers: _headers(auth));
  }

  BaseOptions _optionsFileDownload({bool auth = true}) {
    return BaseOptions(
        baseUrl: Env.apiBaseUrl,
        headers: _headers(auth),
        responseType: ResponseType.bytes);
  }

  String _cleanPath(String path) {
    if (!path.endsWith("/")) {
      return "$path/";
    }

    return path;
  }

  Map<String, dynamic> buildPage(int page) {
    return {'page': page};
  }

  Map<String, dynamic> buildLimit(int limit) {
    return {'limit': limit};
  }

  Map<String, dynamic> buildOwner(int userId) {
    return {'owner': userId};
  }

  Map<String, dynamic> buildStatus(String status) {
    return {'status': status};
  }

  Future<Map<String, dynamic>> getHttp(
    String path, {
    Map<String, dynamic> params = const {},
    bool auth = true,
  }) async {
    try {
        setSessionSPLog(path, params);
      var response = await Dio(_options(auth: auth)).get(
        _cleanPath(path),
        queryParameters: params,
      );

      if (response.statusCode == 204) {
        return {};
      }
      if (response.data == null) {
        return {};
      }

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> ssrsDownload(String path, String filename,
      {Map<String, dynamic> params = const {}, bool auth = true}) async {
    try {

      final dio = Dio(_optionsFileDownload(
        auth: auth,
      ));
      Response<List<int>> rs =
          await dio.post(path, data: params, onReceiveProgress: (a, b) {});
      final stream = Stream.fromIterable(rs.data!);
      await download(stream, filename);
      return Returndata(); //
    } on DioException catch (e2) {
      if (e2.response != null) {
        String s = String.fromCharCodes(e2.response!.data);
        final errReturn = Returndata.fromJson(json.decode(s));
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();

      // rethrow;
    }
  }
  Future<dynamic> excelDownload(String path,String filename,
      {Map<String, dynamic> params = const {}, bool auth = true}) async {
    try {
  
     final dio = Dio(_optionsFileDownload(
        auth: auth,
      ));

      Response<List<int>> rs =
          await dio.post(path, data: params, onReceiveProgress: (a, b) {});
      final stream = Stream.fromIterable(rs.data!);
      await download(stream, filename).then((v){
       
      });
      // final uploader = ChunkedUploader(dio);
      // final response = await uploader.upload(
      //   fileName: file.name,
      //   fileSize: file.size,
      //   fileDataStream: file.readStream!,
      //   maxChunkSize: 500000,
      //   path: _cleanPath(path),
      // );

      // if (showMsg) {
      //   if (returnData.message!.msgSeverity != 0) {
      //     Toast.error('[${returnData.message!.msgId}] ${returnData.message!.dscp}');
      //   } else {
      //     Toast.success(returnData.message!.dscp.toString());
      //   }
      // }
      return Returndata();

      //
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();

      // rethrow;
    }
  }

  Future<dynamic> postDownload(String path,
      {Map<String, dynamic> params = const {}, bool auth = true}) async {
    try {

      String filename = params['key'].toString().split('/').last;
      final dio = Dio(_optionsFileDownload(
        auth: auth,
      ));

      Response<List<int>> rs =
          await dio.post(path, data: params, onReceiveProgress: (a, b) {});
      final stream = Stream.fromIterable(rs.data!);
      await download(stream, filename).then((v){
       
      });
      // final uploader = ChunkedUploader(dio);
      // final response = await uploader.upload(
      //   fileName: file.name,
      //   fileSize: file.size,
      //   fileDataStream: file.readStream!,
      //   maxChunkSize: 500000,
      //   path: _cleanPath(path),
      // );

      // if (showMsg) {
      //   if (returnData.message!.msgSeverity != 0) {
      //     Toast.error('[${returnData.message!.msgId}] ${returnData.message!.dscp}');
      //   } else {
      //     Toast.success(returnData.message!.dscp.toString());
      //   }
      // }
      return Returndata();

      //
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();

      // rethrow;
    }
  }

  Future<dynamic> postUploadMulti(String path,
      {Map<String, dynamic> params = const {}, bool auth = true}) async {
    try {
    
      final dataFile = await FilePicker.platform
              .pickFiles(withReadStream: true, allowMultiple: true);
      if(dataFile ==null){
        return Returndata();
      }

      final file = dataFile
          .files;
      if (file.isEmpty) {
        return Returndata();
      }
      final dio = Dio(_options(auth: auth));
      final uploader = ChunkedUploader(dio);
      var futures = <Future>[];
      for (var i = 0; i < file.length; i++) {
        final responseFuture = uploader.upload(
            fileName: file[i].name,
            fileSize: file[i].size,
            fileDataStream: file[i].readStream!,
            // maxChunkSize: 500000,
         //  path: _cleanPath(path),
         //Cannot cleanpath because we need to post QueryString
         path: path,
            onUploadProgress: (val) {});
        futures.add(responseFuture);
      }
      await Future.wait(futures).then((value) {
        return Returndata();
      });
      // if (response!.statusCode == 204) {
      //   return Returndata();
      // }

      return Returndata();
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();
    }
  }

  Future<dynamic> postUpload(String path,
      {Map<String, dynamic> params = const {}, bool auth = true}) async {
    try {
      final file = (await FilePicker.platform.pickFiles(withReadStream: true))!
          .files
          .single;

      final dio = Dio(_options(auth: auth));
      final uploader = ChunkedUploader(dio);
      final response = await uploader.upload(
          fileName: file.name,
          fileSize: file.size,
          fileDataStream: file.readStream!,
          // maxChunkSize: 500000,
          path: _cleanPath(path),
          onUploadProgress: (val) {});

      if (response!.statusCode == 204) {
        return Returndata();
      }

      return Returndata();
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();
    }
  }

  Future<Returndata> postHttpReturnData(String path,
      {Map<String, dynamic> params = const {},
     
      bool auth = true,
      bool showMsg = false}) async {
    try {

   setSessionSPLog( path, params);
 
      final response = await Dio(_options(auth: auth)).post(
        //_cleanPath(path),
        path,
        data: params,
      );

      if (response.statusCode == 204) {
        return Returndata();
      }
      if (response.data == null || response.data == "") {
        return Returndata();
      }
      final returnData = Returndata.fromJson(response.data);

      if (showMsg) {
        if (returnData.message != null) {
          if (returnData.message!.msgSeverity != 0) {
            Toast.error(
                '[${returnData.message!.msgId}] ${returnData.message!.dscp}');
          } else {
            Toast.success(returnData.message!.dscp.toString());
          }
        }
      }
      return returnData;

      //
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return Returndata();
    } catch (e) {
      Toast.error(e.toString());
      return Returndata();

      // rethrow;
    }
  }

  void setSessionSPLog(String path, Map<String, dynamic> params) {
       String? curUser =  singleton<Storage>().getString('login_email');
     if(curUser != null && curUser == logSPUserName){
      var item = {
      "sp":path,
      "params":params,
      "timestamp": DateTime.now().toIso8601String()
    };
       web.Storage sessionStorage = web.window.sessionStorage;
          sessionStorage.setItem(path, JsonEncoder().convert(item));
    }
  }

  Future<MultiReturndata> postHttpMultiReturnData(String path,
      {Map<String, dynamic> params = const {},
      bool auth = true,
      bool showMsg = false}) async {
    try {
        setSessionSPLog(path, params);
      final response = await Dio(_options(auth: auth)).post(
        _cleanPath(path),
        data: params,
      );

      if (response.statusCode == 204) {
        return MultiReturndata();
      }
      if (response.data == null || response.data == "") {
        return MultiReturndata();
      }
      final multiReturndata =
          MultiReturndata.fromJson({'multidata': response.data});

      // if (showMsg) {
      //   if (returnData.message != null) {
      //     if (returnData.message!.msgSeverity != 0) {
      //       Toast.error(
      //           '[${returnData.message!.msgId}] ${returnData.message!.dscp}');
      //     } else {
      //       Toast.success(returnData.message!.dscp.toString());
      //     }
      //   }
      // }
      return multiReturndata;

      //
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = MultiReturndata.fromJson(e2.response!.data);
        //   Toast.error(errReturn.error['errorMessage']);
        return errReturn;
      }
      Toast.error('Unknown error $e2');
      return MultiReturndata();
    } catch (e) {
      Toast.error(e.toString());
      return MultiReturndata();

      // rethrow;
    }
  }

  Future<Map<String, dynamic>> postHttpS3Delete(
    String path, {
    Map<String, dynamic> params = const {},
    bool auth = true,
  }) async {
    try {
    
      var response = await Dio(_options(auth: auth)).post(
        //_cleanPath(path),
        path,
        data: params,
      );

      if (response.statusCode == 204) {
        return {};
      }
      if (response.data == null || response.data == "") {
        return {};
      }

      return {'Sts': response.data};
      // } on DioError catch (e2) {
      //   // if (e2.response!.statusCode == 401) {
      //   //   // singleton<Storage>().remove(Token.AUTH_TOKEN_KEY);
      //   //   // final context = rootNavigatorKey.currentContext!;
      //   //   // singleton<AppRouter>().replace(const AuthLandingScreenRoute());

      //   // }
      //   rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postHttp(
    String path,{
    Map<String, dynamic> params = const {},
    bool auth = true,
  }) async {
    try {

        setSessionSPLog(path, params);
      var response = await Dio(_options(auth: auth)).post(
        //Cannoot do clean path because of LogId
        _cleanPath(path),
        data: params,
      );

      if (response.statusCode == 204) {
        return {};
      }
      if (response.data == null || response.data == "") {
        return {};
      }

      return response.data;
    } on DioException catch (e2) {
      if (e2.response != null) {
        final errReturn = Returndata.fromJson(e2.response!.data);
        Toast.error("[${errReturn.message!.msgId}] ${errReturn.message!.dscp}");
        return {};
      }
      Toast.error('Unknown error $e2');
      return {};
    } catch (e) {
      Toast.error(e.toString());
      return {};

      // rethrow;
    }
    //   // } on DioError catch (e2) {
    //   //   // if (e2.response!.statusCode == 401) {
    //   //   //   // singleton<Storage>().remove(Token.AUTH_TOKEN_KEY);
    //   //   //   // final context = rootNavigatorKey.currentContext!;
    //   //   //   // singleton<AppRouter>().replace(const AuthLandingScreenRoute());

    //   //   // }
    //   //   rethrow;
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<Map<String, dynamic>> patchHttp(
    String path, {
    Map<String, dynamic> params = const {},
    bool auth = true,
  }) async {
    try {
      var response = await Dio(_options(auth: auth)).patch(
        _cleanPath(path),
        data: params,
      );
      if (response.statusCode == 204) {
        return {};
      }
      if (response.data == null) {
        return {};
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
