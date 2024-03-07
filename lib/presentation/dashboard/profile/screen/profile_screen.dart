import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/dashboard/profile/widgets/profile_card_widget.dart';
import 'package:black_pearl/presentation/routes/app_route_name.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/localstorage/shared_preference_service.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:core/utils/asset_image_path_constants.dart';
import 'package:core/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injector.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bloc = ProfileBloc(preference: getIt<SharedPreferenceService>());
  final _loadingOverlay = LoadingOverlay(color: ColorConstants.lavenderMist);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child:
          BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state is ProfileLoadingState) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }
        if (state is ProfileEditState) {
          context.beamToNamed(AppRouteName.profileEdit);
        }
        if (state is ProfileSuccessfulLogoutState) {
          context.beamToNamed(AppRouteName.login);
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: Center(
                  child: CircleAvatar(
                    radius: AppConstants.loginLogoRadius,
                    backgroundImage: AssetImage(
                      AssetImagePath.blackPearlLogo,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileCardWidget(
                        icon: Icons.edit_note_outlined,
                        text: "Edit Profile",
                        onTapEvent: () {
                          bloc.add(ProfileEditClickedEvent());
                        },
                      ),
                      ProfileCardWidget(
                        icon: Icons.chat_bubble,
                        text: "Help & Support",
                        onTapEvent: () {},
                      ),
                      ProfileCardWidget(
                        icon: Icons.logout,
                        text: "Logout",
                        onTapEvent: () {
                          bloc.add(ProfileLogoutClickedEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Privacy Policy",
                        style: Styles.h5w400.merge(
                          const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Terms & Condition",
                        style: Styles.h5w400.merge(
                          const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
