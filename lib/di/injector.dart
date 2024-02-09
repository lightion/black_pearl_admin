import 'package:black_pearl/presentation/login/bloc/login_bloc.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:data/repository/phone_auth_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

getItInit() async {
  //Shared Preference
  final sharedPreference = SharedPreferenceService();
  getIt.registerLazySingleton<SharedPreferenceService>(() => sharedPreference);

  //Repository
  final authRepository = PhoneAuthRepository();
  getIt.registerLazySingleton<PhoneAuthRepository>(() => authRepository);

  // bloc
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(phoneAuthRepository: authRepository));
}
