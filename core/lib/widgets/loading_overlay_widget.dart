import 'package:core/theme/styles.dart';
import 'package:flutter/material.dart';

import '../theme/color_constants.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;
  bool isOverlay;
  Color color;
  String message;
  int? size = 48;
  double? loadingStrokeWidth = 4;

  LoadingOverlay({
    this.isOverlay = true,
    required this.color,
    this.message = "",
    this.size,
    this.loadingStrokeWidth,
  });

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => ColoredBox(
          color:
              isOverlay ? ColorConstants.black80 : ColorConstants.transparent,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size?.toDouble(),
                  height: size?.toDouble(),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(color),
                    strokeWidth: loadingStrokeWidth ?? 4,
                  ),
                ),
                message != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: DefaultTextStyle(
                          style: Styles.h5w400,
                          child: Text(message),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }
}
