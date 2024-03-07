import 'package:black_pearl/di/injector.dart';
import 'package:black_pearl/presentation/dashboard/list/bloc/list_bloc.dart';
import 'package:black_pearl/presentation/dashboard/list/widgets/list_menu_card.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:domain/entities/menu/get_menu_entity.dart';
import 'package:domain/usecases/menu/get_menu_usecase.dart';
import 'package:flutter/material.dart';
import 'package:core/data/menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // List<MenuItem> menuList = <MenuItem>[
  //   MenuItem(
  //     url:
  //         "https://5.imimg.com/data5/SELLER/Default/2023/7/327860090/HT/LI/RZ/48567411/restaurant-menu-card-printing-service.jpg",
  //     title: "Lunch",
  //   ),
  //   MenuItem(
  //     url:
  //         "https://5.imimg.com/data5/SL/BC/RY/SELLER-54701692/menu-card-printing-service.jpeg",
  //     title: "Dinner",
  //   ),
  // ];

  final bloc = ListBloc(
    getMenuUseCase: getIt<GetMenuUseCase>(),
    preference: getIt<SharedPreferenceService>(),
  );

  GetMenuEntity? lunchMenu;
  GetMenuEntity? dinnerMenu;
  final _loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(ListInitialEvent()),
      child: BlocConsumer<ListBloc, ListState>(
        listener: (context, state) {
          if(state is ListLoadingState) {
            _loadingOverlay.show(context);
          } else {
            _loadingOverlay.hide();
          }
          if (state is ListLunchSuccessState) {
            lunchMenu = state.menu;
          } else if (state is ListLunchFailedState) {
            lunchMenu = null;
          }
          if (state is ListDinnerSuccessState) {
            dinnerMenu = state.menu;
          } else if (state is ListDinnerFailedState) {
            dinnerMenu = null;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: /*ListView.builder(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return ListMenuCard(
                    imageURL: menuList[index].url,
                    title: menuList[index].title,
                  );
                },
              ),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: lunchMenu != null,
                    child: ListMenuCard(
                      imageURL: lunchMenu?.menuImageURL ?? "",
                      title: "Lunch",
                      deleteButtonPressed: (){},
                    ),
                  ),
                  Visibility(
                    visible: dinnerMenu != null,
                    child: ListMenuCard(
                      imageURL: dinnerMenu?.menuImageURL ?? "",
                      title: "Dinner",
                      deleteButtonPressed: (){},
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
}
