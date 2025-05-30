import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bccm_core/design_system.dart';
import 'buttons.dart';
import 'decorations.dart';
import 'text_styles.dart';
import 'colors.dart';

class BccMediaDesignSystem extends DesignSystemData {
  BccMediaDesignSystem._raw({
    required super.colors,
    required super.textStyles,
    required super.materialThemeData,
    required super.buttons,
    required super.inputDecorations,
  });
  factory BccMediaDesignSystem() {
    final colors = BccMediaColors();
    final textStyles = BccMediaTextStyles(colors: colors);
    return BccMediaDesignSystem._raw(
      colors: colors,
      textStyles: textStyles,
      buttons: BccMediaButtons(colors: colors, textStyles: textStyles),
      inputDecorations: BccMediaInputDecorations(colors: colors, textStyles: textStyles),
      materialThemeData: ThemeData(
        useMaterial3: true,
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: colors.background1,
          textTheme: CupertinoTextThemeData(
            tabLabelTextStyle: textStyles.caption3,
          ),
        ),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: colors.tint1,
          surface: colors.background2,
        ),
        fontFamily: 'Barlow',
        canvasColor: colors.background1,
        highlightColor: colors.background2.withOpacity(0.5),
        splashColor: colors.background2.withOpacity(1),
        sliderTheme: SliderThemeData(inactiveTrackColor: colors.separatorOnLight),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: colors.tint1,
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((state) => state.contains(WidgetState.selected) ? colors.tint1 : colors.separatorOnLight),
          thumbColor: WidgetStateProperty.resolveWith((state) => colors.onTint),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: textStyles.title3.copyWith(height: 1),
          toolbarTextStyle: textStyles.button2,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 44,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: colors.tint1),
          backgroundColor: colors.background1,
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: colors.background2,
          contentTextStyle: textStyles.body1,
          titleTextStyle: textStyles.title3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        scaffoldBackgroundColor: colors.background1,
        bottomSheetTheme: const BottomSheetThemeData(
          constraints: BoxConstraints(maxWidth: double.infinity),
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colors.tint1,
          elevation: 0,
          selectedLabelStyle: textStyles.caption3.copyWith(color: colors.tint1),
          unselectedLabelStyle: textStyles.caption3,
        ),
        typography: Typography.material2021().copyWith(
          white: Typography.material2021().white.copyWith(
                headlineMedium: textStyles.headline2,
                bodyLarge: textStyles.body1,
                bodyMedium: textStyles.body2,
              ),
        ),
      ),
    );
  }
}
