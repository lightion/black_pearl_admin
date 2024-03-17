import 'package:black_pearl/presentation/login/bloc/login_bloc.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:data/core/chopper_client.dart';
import 'package:data/core/image_chopper_client.dart';

//Mapper
import 'package:data/mappers/add_restaurant_mapper.dart';
import 'package:data/mappers/image/add_image_mapper.dart';
import 'package:data/mappers/menu/delete_menu_mapper.dart';
import 'package:data/mappers/menu/get_menu_mapper.dart';
import 'package:data/mappers/restaurant_mapper.dart';
import 'package:data/mappers/restaurants_mapper.dart';
import 'package:data/mappers/menu/add_menu_mapper.dart';
import 'package:data/mappers/update_restaurant_status_mapper.dart';

//Service
import 'package:data/repository/phone_auth_repository.dart';
import 'package:data/services/restaurant_image_service.dart';
import 'package:data/services/restaurant_service.dart';
import 'package:data/services/menu/menu_service.dart';

//Remote DataSource
import 'package:data/datasources/restaurant_remote_data_source.dart';
import 'package:data/datasources/menu/menu_remote_data_source.dart';

//Repository
import 'package:domain/repositories/menu/menu_repository.dart';
import 'package:domain/repositories/restaurant_repository.dart';
import 'package:data/repository/restaurant_repository_impl.dart';
import 'package:data/repository/menu/menu_repository_impl.dart';

//Usecase
import 'package:domain/usecases/get_restaurants_usecase.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_add_restaurant_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_status_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_usecase.dart';
import 'package:domain/usecases/menu/post_add_menu_usecase.dart';
import 'package:domain/usecases/menu/get_menu_usecase.dart';
import 'package:domain/usecases/menu/delete_menu_usecase.dart';
import 'package:domain/usecases/post_upload_image_usecase.dart';
import 'package:domain/usecases/post_upload_restaurant_image_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

getItInit() async {
  //Shared Preference
  final sharedPreference = SharedPreferenceService();
  getIt.registerLazySingleton<SharedPreferenceService>(() => sharedPreference);

  //Api Client and Service
  final client = AppChopperClient.createChopperClient();

  final imageClient = ImageChopperClient.createChopperClient();

  final restaurantService = RestaurantService.create(client);
  final menuService = MenuService.create(client);
  final restaurantImageService = RestaurantImageService.create(imageClient);

  getIt.registerLazySingleton<RestaurantService>(() => restaurantService);
  getIt.registerLazySingleton<MenuService>(() => menuService);
  getIt.registerLazySingleton<RestaurantImageService>(
      () => restaurantImageService);

  // use case
  getIt
      .registerLazySingleton<GetRestaurantsUseCase>(() => GetRestaurantsUseCase(
            repository: getIt(),
          ));
  getIt.registerLazySingleton<GetRestaurantByMobileUseCase>(
      () => GetRestaurantByMobileUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostAddRestaurantUseCase>(
      () => PostAddRestaurantUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostUpdateRestaurantUseCase>(
      () => PostUpdateRestaurantUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostAddMenuUseCase>(
      () => PostAddMenuUseCase(repository: getIt()));

  getIt.registerLazySingleton<PostUploadImageUseCase>(
      () => PostUploadImageUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostUploadRestaurantImageUseCase>(
          () => PostUploadRestaurantImageUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetMenuUseCase>(
      () => GetMenuUseCase(repository: getIt()));
  getIt.registerLazySingleton<PostUpdateRestaurantStatusUseCase>(
      () => PostUpdateRestaurantStatusUseCase(repository: getIt()));
  getIt.registerLazySingleton<DeleteMenuUseCase>(
      () => DeleteMenuUseCase(repository: getIt()));

  //Repository
  final authRepository = PhoneAuthRepository();
  getIt.registerLazySingleton<PhoneAuthRepository>(() => authRepository);

  getIt.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(
            remoteDataSource: getIt(),
            mapper: getIt(),
            restaurantMapper: getIt(),
            addRestaurantMapper: getIt(),
            addImageMapper: getIt(),
            statusMapper: getIt(),
          ));
  getIt.registerLazySingleton<MenuRepository>(() => MenuRepositoryImpl(
        remoteDataSource: getIt(),
        addMenuMapper: getIt(),
        getMenuMapper: getIt(),
        deleteMenuMapper: getIt(),
      ));

  // bloc
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(
        phoneAuthRepository: authRepository,
        useCase: getIt(),
        mobileUseCase: getIt(),
        preference: getIt(),
      ));

  // data source
  getIt.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(
            restaurantService: restaurantService,
            restaurantImageService: restaurantImageService,
          ));

  getIt.registerLazySingleton<MenuRemoteDataSource>(
      () => MenuRemoteDataSourceImpl(menuService: menuService));

  // mapper
  getIt.registerLazySingleton<RestaurantsMapper>(() => RestaurantsMapper());
  getIt.registerLazySingleton<RestaurantMapper>(() => RestaurantMapper());
  getIt.registerLazySingleton<AddRestaurantMapper>(() => AddRestaurantMapper());
  getIt.registerLazySingleton<AddMenuMapper>(() => AddMenuMapper());
  getIt.registerLazySingleton<AddImageMapper>(() => AddImageMapper());
  getIt.registerLazySingleton<GetMenuMapper>(() => GetMenuMapper());
  getIt.registerLazySingleton<UpdateRestaurantStatusMapper>(
      () => UpdateRestaurantStatusMapper());
  getIt.registerLazySingleton<DeleteMenuMapper>(() => DeleteMenuMapper());
}
