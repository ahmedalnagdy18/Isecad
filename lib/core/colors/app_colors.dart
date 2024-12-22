import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  //primary colors
  static Color white = const Color(0xffFFFFFF);
  static Color backgroundColor = const Color(0xffF5F5F5);
  static Color lightGrey = const Color(0xffF5F5F5);
  static Color grey = const Color(0xffEAEAEA);
  static Color darkGrey = const Color(0xffCCCCCC);
  static Color facebook = const Color(0xff1877F2);
  static Color tapBorder = const Color(0xff858589);
  static Color textfieldBorder = const Color(0xFF9D9C99);
  static Color clickedTextfieldBorder = const Color(0xFF858589);
  static Color iconAdd = const Color(0xFF6A717F);
  static Color toastmessage = const Color(0xff04FFAA);
  //text colors
  static Color hintText = const Color(0xFF9D9C99);
  static Color forgetPassword = const Color(0xFF6A717F);
  static Color appBarRed = const Color(0xFFFF2D55);
  static Color errorColor = const Color(0xFFB71A2A);
  static Color errorOrangeColor = const Color(0xFFFF9139);

  // static Color n5 = const Color(0x002a3838);

  //Gradients
  static List<Color> mainRed = const [
    Color(0xffEF3E2C),
    Color(0xffE71F63),
  ];
  static List<Color> greyLoader = const [
    Color(0xffE0E0E0),
    Color(0xffE0E0E0),
  ];
  static List<Color> mainToastmessage = const [
    Color(0xff04FFAA),
    Color(0xff00F2D0),
  ];

  static List<Color> onbording1 = [
    const Color(0xff8B4EFF).withOpacity(0.40),
    const Color(0xff6549FF).withOpacity(0.25),
    const Color(0x056549FF).withOpacity(0.01)
  ];
  static List<Color> onbording2 = [
    // from bottom to top
    const Color(0xff00F2D0).withOpacity(0.40),
    const Color(0xff00F2D0).withOpacity(0.17),
    const Color(0xff00F2D0).withOpacity(0.01),
  ];
  static List<Color> onbording3 = [
    const Color(0xff241C60).withOpacity(0.70),
    const Color(0xff171047).withOpacity(0.50),
    const Color(0xff171047).withOpacity(0.01),
  ];
}
