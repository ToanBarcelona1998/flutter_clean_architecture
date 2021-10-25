import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const bodyColor = Color(0xffc1c3c7);
  static const whiteColor = Color(0xffffffff);
  static const blackColor = Color(0xff000000);
  static const appBarColor = Color(0xff6278a3);
  static const unCheckColor = Color(0xff73919c);
  static const checkColor = Color(0xff0f6e91);
  static const buttonColor = Color(0xff0c679c);
  static const splashColor = Color(0xffa19a87);
  static const textButtonColor = Color(0xff4d7a8c);
  static const transparentColor = Colors.transparent;
  static const buttonDelete = Color(0xffc75048);
  static const buttonEdit = Color(0xff947646);

  static ThemeData get lightTheme => ThemeData(
        platform: TargetPlatform.iOS,
        scaffoldBackgroundColor: bodyColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: whiteColor,
          unselectedLabelStyle: TextStyle(fontSize: 12, color: unCheckColor),
          unselectedIconTheme: IconThemeData(size: 16, color: unCheckColor),
          selectedLabelStyle: TextStyle(fontSize: 14, color: checkColor),
          selectedIconTheme: IconThemeData(size: 16, color: checkColor),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: appBarColor,
          titleTextStyle: TextStyle(fontSize: 22, color: whiteColor, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          height: 50,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          textTheme: ButtonTextTheme.accent,
          buttonColor: buttonColor,
          splashColor: splashColor,
        ),
        iconTheme: const IconThemeData(
          size: 16,
          color: whiteColor,
        ),
        textTheme: TextTheme(
          headline1: _headline1,
          headline2: _headline2,
          headline3: _headline3,
          headline4: _headline4,
          headline5: _headline5,
          headline6: _headline6,
          bodyText1: _bodyText1,
          bodyText2: _bodyText2,
          subtitle1: _subTitle1,
          subtitle2: _subTitle2,
          button: _button,
          caption: _caption,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        platform: TargetPlatform.iOS,
      );

  static TextStyle get _headline1 => GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold);

  static TextStyle get _headline2 => GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w900);

  static TextStyle get _headline3 => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w800);

  static TextStyle get _headline4 => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w700);

  static TextStyle get _headline5 => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle get _headline6 => GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle get _bodyText1 => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get _bodyText2 => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle get _subTitle1 => GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle get _subTitle2 => GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500);

  static TextStyle get _button => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: textButtonColor);

  static TextStyle get _caption => GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700);
}
