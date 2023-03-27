import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';
import 'theme_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle? get _whiteHeadline6 =>
      _poppinsTextTheme.headline6?.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle? get _whiteHeadline5 =>
      _poppinsTextTheme.headline5?.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle? get whiteSubtitle1 => _poppinsTextTheme.subtitle1?.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  static TextStyle? get _whiteButton => _poppinsTextTheme.button?.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle? get whiteBodyText2 => _poppinsTextTheme.bodyText2?.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle? get _darkCaption => _poppinsTextTheme.caption?.copyWith(
        color: AppColor.primaryColor,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle? get _primaryColorHeadline6 =>
      _whiteHeadline6?.copyWith(color: AppColor.primaryColor);

  static TextStyle? get _primaryColorHeadline5 =>
      _whiteHeadline5?.copyWith(color: AppColor.primaryColor);

  static TextStyle? get primaryColorSubtitle1 =>
      whiteSubtitle1?.copyWith(color: AppColor.primaryColor);

  static TextStyle? get primaryColorBodyText2 =>
      whiteBodyText2?.copyWith(color: AppColor.primaryColor);

  static TextStyle? get _lightCaption =>
      _darkCaption?.copyWith(color: Colors.white);

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: whiteSubtitle1,
        bodyText2: whiteBodyText2,
        button: _whiteButton,
        caption: _darkCaption,
      );

  static getLightTextTheme() => TextTheme(
        headline5: _primaryColorHeadline5,
        headline6: _primaryColorHeadline6,
        subtitle1: primaryColorSubtitle1,
        bodyText2: primaryColorBodyText2,
        button: _whiteButton,
        caption: _lightCaption,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle? get primaryColorSubtitle1 => subtitle1?.copyWith(
      color: AppColor.primaryColor, fontWeight: FontWeight.w600);

  TextStyle? get greySubtitle1 => subtitle1?.copyWith(color: Colors.grey);

  TextStyle? get violetHeadline6 => headline6?.copyWith(color: AppColor.primaryColor);

  TextStyle? get primaryColorBodyText2 =>
      bodyText2?.copyWith(color: AppColor.primaryColor, fontWeight: FontWeight.w600);

  TextStyle? get whiteBodyText2 =>
      primaryColorBodyText2?.copyWith(color: Colors.white);

  TextStyle? get greyCaption => caption?.copyWith(color: Colors.grey);

  TextStyle? get orangeSubtitle1 =>
      subtitle1?.copyWith(color: Colors.orangeAccent);
}
