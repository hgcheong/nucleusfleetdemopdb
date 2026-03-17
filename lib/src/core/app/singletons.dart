
import 'package:get_it/get_it.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:nucleusv2/src/core/app_router.dart';
//import 'package:nucleusv2/src/utils/acx_authaccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

final singleton = GetIt.instance;

Future<void> initSingletons() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  singleton.registerLazySingleton<SharedPreferences>(() => sharedPreferences);  
    //  singleton.registerSingletonAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());
  singleton.registerSingleton<AppRouter>(AppRouter());  
//  singleton.registerSingleton<AcxAuthAccess>(AcxAuthAccess());
  singleton.registerLazySingleton<Storage>(
    () => StorageImplementation(),
  );
 // singleton.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

}
