import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/core/app/api_service.dart';
import 'package:nucleusv2/src/core/models/libref/libref.dart';
import 'package:nucleusv2/src/core/models/query_object.dart';

import 'package:nucleusv2/src/core/models/returndata/returndata.dart';
import 'package:nucleusv2/src/core/models/vw_schd_billing_item/vw_schd_billing_item.dart';

class ApiAcxDataTableServiceForRiverpod extends ApiService {
  ApiAcxDataTableServiceForRiverpod();

  Future<Returndata> retrieveData(
      String querysql, Map<String, dynamic> params) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);
      return returnData;
    } catch (e) {
      return Returndata();
    }
  }
}

class ApiAcxDataTableService extends ApiService {
  ApiAcxDataTableService();

  Future<Returndata> retrieveData(
      String querysql, Map<String, dynamic> params) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);
      return returnData;
    } catch (e) {
      return Returndata();
    }
  }

  Future<List<Libref>> retrieveLibref(
      String querysql, Map<String, dynamic> params) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);
      final returnRef = Libref.fromJsonList(returnData.data!.toList());
      return returnRef;
    } catch (e) {
      return [];
    }
  }

  Future<List<VwSchdBillingItem>> retrieveVwShcd(
      String querysql, Map<String, dynamic> params) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);
      final returnRef =
          VwSchdBillingItem.fromJsonList(returnData.data!.toList());
      return returnRef;
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> retrieveAsList(
      String querysql, Map<String, dynamic> params,String keyField,bool sortByKeyValue) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);

      if (returnData.data != null) {
         if(sortByKeyValue){
        var toReturn = returnData.data!
          .toList();
          toReturn.sort((a,b)=>a[keyField].compareTo(b[keyField]));
        return toReturn;
      }
        
       var toSort = returnData.columnInfo!.where((element) {
         return element.data == "SortSeq";
        },);
           if(toSort.isNotEmpty && returnData.data![0]['SortSeq']!= 0){
              var toReturn = returnData.data!
          .toList();
          toReturn.sort((a,b)=>a['SortSeq'].compareTo(b['SortSeq']));
        return toReturn;
          }
        return returnData.data!.toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> retrieveAsListWithFilter(String querysql,
      Map<String, dynamic> params, String keyField, String filterValue ,bool sortByKeyValue) async {
    try {
      final response = await postHttp(querysql, params: params);
      final returnData = Returndata.fromJson(response);
      if(sortByKeyValue){
        var toReturn = returnData.data!
          .where((element) => element[keyField] == filterValue)
          .toList();
          toReturn.sort((a,b)=>a[keyField].compareTo(b[keyField]));
        return toReturn;
      }
          var toSort = returnData.columnInfo!.where((element) {
         return element.data == "SortSeq";
        },);
          if(toSort.isNotEmpty && returnData.data![0]['SortSeq']!= 0){
              var toReturn = returnData.data!
                    .where((element) => element[keyField] == filterValue)
          .toList();
          toReturn.sort((a,b)=>a['SortSeq'].compareTo(b['SortSeq']));
        return toReturn;
          }

      return returnData.data!
          .where((element) => element[keyField] == filterValue)
          .toList();
    } catch (e) {
      return Returndata().data!;
    }
  }
}

final repoQueryProvider = Provider<ApiAcxDataTableService>((ref) {
  return ApiAcxDataTableService();
});

final querySearchProvider =
    FutureProvider.family<Returndata, TheQueryObject>((ref, query) async {
  final repo = ref.watch(repoQueryProvider);
  return repo.retrieveData(query.querysql, query.params);
});

final querySearchStateProvider = StateProvider<TheQueryObject>((ref) {
  return TheQueryObject('', {});
});

final querySearchResultProvider = FutureProvider<Returndata>((ref) async {
  final theQuery = ref.watch(querySearchStateProvider);
  return ref.watch(querySearchProvider(theQuery).future);
});
