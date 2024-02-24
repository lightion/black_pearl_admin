import 'package:black_pearl/presentation/login/bloc/login_bloc.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:data/core/chopper_client.dart';
import 'package:data/mappers/add_restaurant_mapper.dart';
import 'package:data/mappers/restaurant_mapper.dart';
import 'package:data/repository/phone_auth_repository.dart';
import 'package:data/services/restaurant_service.dart';
import 'package:data/datasources/restaurant_remote_data_source.dart';
import 'package:data/mappers/restaurants_mapper.dart';
import 'package:domain/repositories/restaurant_repository.dart';
import 'package:data/repository/restaurant_repository_impl.dart';
import 'package:domain/usecases/get_restaurants_usecase.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_add_restaurant_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

getItInit() async {
  //Shared Preference
  final sharedPreference = SharedPreferenceService();
  getIt.registerLazySingleton<SharedPreferenceService>(() => sharedPreference);

  //Api Client and Service
  final client = AppChopperClient.createChopperClient();

  final restaurantService = RestaurantService.create(client);
  getIt.registerLazySingleton<RestaurantService>(() => restaurantService);

  // use case
  getIt
      .registerLazySingleton<GetRestaurantsUseCase>(() => GetRestaurantsUseCase(
            repository: getIt(),
          ));
  getIt.registerLazySingleton<GetRestaurantByMobileUseCase>(
      () => GetRestaurantByMobileUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostAddRestaurantUseCase>(
      () => PostAddRestaurantUseCase(repository: getIt()));

  //Repository
  final authRepository = PhoneAuthRepository();
  getIt.registerLazySingleton<PhoneAuthRepository>(() => authRepository);

  getIt.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(
            remoteDataSource: getIt(),
            mapper: getIt(),
            restaurantMapper: getIt(),
            addRestaurantMapper: getIt(),
          ));

  // bloc
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(
        phoneAuthRepository: authRepository,
        useCase: getIt(),
        mobileUseCase: getIt(),
        preference: getIt(),
      ));

  // data source
  getIt.registerLazySingleton<RestaurantRemoteDataSource>(() =>
      RestaurantRemoteDataSourceImpl(restaurantService: restaurantService));

  // mapper
  getIt.registerLazySingleton<RestaurantsMapper>(() => RestaurantsMapper());
  getIt.registerLazySingleton<RestaurantMapper>(() => RestaurantMapper());
  getIt.registerLazySingleton<AddRestaurantMapper>(() => AddRestaurantMapper());
}
