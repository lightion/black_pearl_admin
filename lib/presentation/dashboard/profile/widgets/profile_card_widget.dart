import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final Icon icon;
  final String text;

  const ProfileCardWidget({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }
}
