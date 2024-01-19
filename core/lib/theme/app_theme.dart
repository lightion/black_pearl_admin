import 'package:core/theme/color_constants.dart';
import 'package:flutter/material.dart';

var theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ColorConstants.black,
  scaffoldBackgroundColor: ColorConstants.antiFlashWhite,
);

class AppTheme extends ChangeNotifier {
  ThemeData _themeData;

  AppTheme(this._themeData);

  get getTheme => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  ThemeData getThemeData() {
    return _themeData;
  }
}
