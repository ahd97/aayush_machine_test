import 'package:aayush_machine_test/core/di/api/repo/user_authentication_repository.dart';
import 'package:aayush_machine_test/core/di/api/repo/user_listing_repository.dart';
import 'package:aayush_machine_test/core/di/api/service/uthentication_services.dart';
import 'package:get_it/get_it.dart';

import 'db/app_db.dart';
import 'di/api/http_client.dart';
import 'navigation/navigation_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerSingleton(HttpClient());
  locator.registerSingleton(NavigationService());

  locator.registerSingletonAsync<AppDB>(() => AppDB.getInstance());

  locator.registerLazySingleton<UserAuthService>(() => UserAuthService());
  locator.registerLazySingleton<UserAuthRepository>(() => UserAuthRepository());
  locator.registerLazySingleton<UserListingRepository>(() => UserListingRepository());
}
