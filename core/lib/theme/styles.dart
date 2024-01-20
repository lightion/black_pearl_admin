import 'package:flutter/material.dart';

class Styles {
  ///fontWeight
  static const fontWeight700 = FontWeight.w700;
  static const fontWeight600 = FontWeight.w600;
  static const fontWeight400 = FontWeight.w400;

  ///fontSize
  static const fontSizeH1 = 32.0;
  static const fontSizeH2 = 28.0;
  static const fontSizeH3 = 24.0;
  static const fontSizeH5 = 16.0;

  ///Headline
  static const h2w700 =
      TextStyle(fontWeight: fontWeight700, fontSize: fontSizeH2);
  static const h5w600 =
      TextStyle(fontWeight: fontWeight600, fontSize: fontSizeH5);
  static const h3w700 = TextStyle(
    fontWeight: fontWeight700,
    fontSize: fontSizeH3,
  );

  ///Body
  static const h5w400 =
      TextStyle(fontWeight: fontWeight400, fontSize: fontSizeH5);
}
