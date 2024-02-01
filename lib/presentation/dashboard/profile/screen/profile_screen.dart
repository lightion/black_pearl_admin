import 'package:beamer/beamer.dart';
import 'package:black_pearl/presentation/dashboard/profile/widgets/profile_card_widget.dart';
import 'package:black_pearl/presentation/routes/app_route_name.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: Center(
              child: CircleAvatar(
                radius: AppConstants.loginLogoRadius,
                backgroundImage: NetworkImage(
                    'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
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
                      context.beamToNamed(AppRouteName.profileEdit);
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
                    onTapEvent: () {},
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
  }
}
