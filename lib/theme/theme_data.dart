import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/constants/colors.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      // buttonColor: buttonBackground,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      primaryColor: accentColor,
      hintColor: accentColor,
      // textSelectionColor: accentColor,
      // textSelectionHandleColor: accentColor,
      // cursorColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor,
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      appBarTheme: AppBarTheme(
        // brightness: brightness,
        color: cardBackground,
        // textTheme: TextTheme(
        //   bodyText1: baseTextTheme.bodyText1!.copyWith(
        //     color: secondaryText,
        //     fontSize: 18,
        //   ),
        // ),
        iconTheme: IconThemeData(
          color: secondaryText,
        ),
      ),
      iconTheme: IconThemeData(
        color: secondaryText,
        size: 16.0,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          secondary: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryText,
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      fontFamily: 'Montserrat',
      unselectedWidgetColor: hexToColor('#DADCDD'),
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          color: primaryText,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: baseTextTheme.headlineMedium!.copyWith(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: baseTextTheme.headlineSmall!.copyWith(
          color: primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: baseTextTheme.titleLarge!.copyWith(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: baseTextTheme.bodyLarge!.copyWith(
          color: secondaryText,
          fontSize: 15,
        ),
        bodyMedium: baseTextTheme.bodyMedium!.copyWith(
          color: primaryText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: baseTextTheme.labelLarge!.copyWith(
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: baseTextTheme.labelMedium!.copyWith(
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
        ),
        labelSmall: baseTextTheme.labelSmall!.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: baseTextTheme.titleMedium!.copyWith(
          color: primaryText,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: baseTextTheme.titleSmall!.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accentColor,
        onPrimary: buttonText,
        secondary: accentColor,
        onSecondary: buttonText,
        error: error,
        onError: buttonText,
        surface: background,
        onSurface: buttonText,
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: ColorConstants.white,
        cardBackground: ColorConstants.secondaryAppColor,
        primaryText: ColorConstants.titleSub,
        secondaryText: ColorConstants.white,
        accentColor: ColorConstants.secondaryAppColor,
        divider: ColorConstants.secondaryAppColor,
        buttonBackground: ColorConstants.titleSub,
        buttonText: ColorConstants.secondaryAppColor,
        disabled: ColorConstants.secondaryAppColor,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: ColorConstants.darkScaffoldBackgroundColor,
        cardBackground: ColorConstants.white,
        primaryText: Colors.white,
        secondaryText: Colors.black,
        accentColor: ColorConstants.white,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: ColorConstants.white,
        disabled: ColorConstants.white,
        error: Colors.red,
      );
}
