import 'package:core/constants/app_constants.dart';
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
          Expanded(
            child: Center(
              child: CircleAvatar(
                radius: AppConstants.loginLogoRadius,
                backgroundImage: NetworkImage(
                    'https://masterbundles.com/wp-content/uploads/2023/03/reestaurent-ai-676.jpg'),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
