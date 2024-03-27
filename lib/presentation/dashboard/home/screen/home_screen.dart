import 'package:beamer/beamer.dart';
import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/dashboard/home/bloc/home_bloc.dart';
import 'package:core/enums/menu_type.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/utils/asset_image_path_constants.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:domain/usecases/get_restaurant_by_mobile_usecase.dart';
import 'package:domain/usecases/post_update_restaurant_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/widgets/animated_toggle_widget.dart';

import '../../../routes/app_route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc(
    mobileUseCase: getIt<GetRestaurantByMobileUseCase>(),
    preference: getIt<SharedPreferenceService>(),
    statusUseCase: getIt<PostUpdateRestaurantStatusUseCase>(),
  );

  final _loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  @override
  Widget build(BuildContext context) {
    bool status = false;
    return BlocProvider(
      create: (context) => bloc..add(HomeInitialEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is HomeLoadingState) {
            _loadingOverlay.show(context);
          } else {
            _loadingOverlay.hide();
          }
          if (state is HomeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is HomeMenuClickedState) {
            context.beamToNamed(
              AppRouteName.homeMenu,
              data: state.type,
            );
          }
          if (state is HomeInitialState) {
            status = state.status;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Image.asset(
                          AssetImagePath.homeImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Menu",
                            style: Styles.h3w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: menuWidget(
                              menuType: MenuType.lunch,
                              imageUrl: AssetImagePath.lunchMenuIcon,
                            ),
                          ),
                          Expanded(
                            child: menuWidget(
                              menuType: MenuType.dinner,
                              imageUrl: AssetImagePath.dinnerMenuIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnimatedToggle(
                          initialPosition: status,
                          values: const ["Online", "Offline"],
                          onToggleCallback: (value) {
                            bloc.add(
                                HomeToggleClickedEvent(updateStatus: !status));
                          },
                          buttonColor: Colors.green,
                          backgroundColor: const Color(0xFFB5C1CC),
                          textColor: const Color(0xFFFFFFFF),
                        ),
                        status
                            ? const Text("Your Restaurant is Online")
                            : const Text("Your Restaurant is Offline"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget menuWidget({required MenuType menuType, required String imageUrl}) {
    return GestureDetector(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(menuType == MenuType.lunch ? "Lunch" : "Dinner"),
        ],
      ),
      onTap: () {
        bloc.add(HomeMenuClickedEvent(type: menuType));
      },
    );
  }
}
