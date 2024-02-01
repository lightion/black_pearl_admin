import 'package:core/theme/color_constants.dart';
import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTapEvent;

  const ProfileCardWidget({
    required this.icon,
    required this.text,
    required this.onTapEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onTapEvent,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          surfaceTintColor: ColorConstants.lavenderMist,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Icon(icon),),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    text,
                    style: Styles.h5w600,
                  ),
                ),
                const Expanded(
                  flex: 0,
                  child: Icon(Icons.chevron_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
