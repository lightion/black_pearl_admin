import 'package:core/localstorage/shared_preference_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

getItInit() async {
  //Shared Preference
  final sharedPreference = SharedPreferenceService();
  getIt.registerLazySingleton<SharedPreferenceService>(() => sharedPreference);
}
