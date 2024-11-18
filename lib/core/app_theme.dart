import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4284350471),
      surfaceTint: Color(4289866281),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288091674),
      onPrimaryContainer: Color(4294960096),
      secondary: Color(4287973186),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294944928),
      onSecondaryContainer: Color(4284095256),
      tertiary: Color(4285399043),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4289271828),
      onTertiaryContainer: Color(4294965495),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294965495),
      onSurface: Color(4280686615),
      onSurfaceVariant: Color(4284039486),
      outline: Color(4287459437),
      outlineVariant: Color(4292984763),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282133803),
      inversePrimary: Color(4294947756),
      primaryFixed: Color(4294957782),
      onPrimaryFixed: Color(4282449923),
      primaryFixedDim: Color(4294947756),
      onPrimaryFixedVariant: Color(4287565333),
      secondaryFixed: Color(4294957782),
      onSecondaryFixed: Color(4282189062),
      secondaryFixedDim: Color(4294947756),
      onSecondaryFixedVariant: Color(4286001196),
      tertiaryFixed: Color(4294957781),
      onTertiaryFixed: Color(4282449921),
      tertiaryFixedDim: Color(4294948010),
      onTertiaryFixedVariant: Color(4287823878),
      surfaceDim: Color(4293842130),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963439),
      surfaceContainer: Color(4294961639),
      surfaceContainerHigh: Color(4294828767),
      surfaceContainerHighest: Color(4294434266),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4284350471),
      surfaceTint: Color(4289866281),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288091674),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4285672744),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289748054),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4285399043),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4289271828),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965495),
      onSurface: Color(4280686615),
      onSurfaceVariant: Color(4283776315),
      outline: Color(4285815126),
      outlineVariant: Color(4287722609),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282133803),
      inversePrimary: Color(4294947756),
      primaryFixed: Color(4291903805),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4289603623),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4289748054),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4287776063),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4292229679),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4289929242),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293842130),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963439),
      surfaceContainer: Color(4294961639),
      surfaceContainerHigh: Color(4294828767),
      surfaceContainerHighest: Color(4294434266),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283301892),
      surfaceTint: Color(4289866281),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4287170321),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282846219),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285672744),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283301890),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287365125),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965495),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4281540381),
      outline: Color(4283776315),
      outlineVariant: Color(4283776315),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282133803),
      inversePrimary: Color(4294961124),
      primaryFixed: Color(4287170321),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284547079),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285672744),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283766548),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287365125),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284612610),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293842130),
      surfaceBright: Color(4294965495),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963439),
      surfaceContainer: Color(4294961639),
      surfaceContainerHigh: Color(4294828767),
      surfaceContainerHighest: Color(4294434266),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294947756),
      surfaceTint: Color(4294947756),
      onPrimary: Color(4285005832),
      primaryContainer: Color(4285661194),
      onPrimaryContainer: Color(4294947242),
      secondary: Color(4294947756),
      onSecondary: Color(4284095000),
      secondaryContainer: Color(4285212451),
      onSecondaryContainer: Color(4294951613),
      tertiary: Color(4294948010),
      onTertiary: Color(4285071363),
      tertiaryContainer: Color(4286709765),
      onTertiaryContainer: Color(4294951867),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4280094735),
      onSurface: Color(4294434266),
      onSurfaceVariant: Color(4292984763),
      outline: Color(4289235334),
      outlineVariant: Color(4284039486),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294434266),
      inversePrimary: Color(4289866281),
      primaryFixed: Color(4294957782),
      onPrimaryFixed: Color(4282449923),
      primaryFixedDim: Color(4294947756),
      onPrimaryFixedVariant: Color(4287565333),
      secondaryFixed: Color(4294957782),
      onSecondaryFixed: Color(4282189062),
      secondaryFixedDim: Color(4294947756),
      onSecondaryFixedVariant: Color(4286001196),
      tertiaryFixed: Color(4294957781),
      onTertiaryFixed: Color(4282449921),
      tertiaryFixedDim: Color(4294948010),
      onTertiaryFixedVariant: Color(4287823878),
      surfaceDim: Color(4280094735),
      surfaceBright: Color(4282791220),
      surfaceContainerLowest: Color(4279700234),
      surfaceContainerLow: Color(4280686615),
      surfaceContainer: Color(4280949787),
      surfaceContainerHigh: Color(4281673253),
      surfaceContainerHighest: Color(4282462511),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294949555),
      surfaceTint: Color(4294947756),
      onPrimary: Color(4281794562),
      primaryContainer: Color(4294401365),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294949555),
      onSecondary: Color(4281729539),
      secondaryContainer: Color(4291917936),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294949552),
      onTertiary: Color(4281794561),
      tertiaryContainer: Color(4294792776),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4280094735),
      onSurface: Color(4294965753),
      onSurfaceVariant: Color(4293313471),
      outline: Color(4290550680),
      outlineVariant: Color(4288314489),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294434266),
      inversePrimary: Color(4287696918),
      primaryFixed: Color(4294957782),
      onPrimaryFixed: Color(4281139202),
      primaryFixedDim: Color(4294947756),
      onPrimaryFixedVariant: Color(4285726730),
      secondaryFixed: Color(4294957782),
      onSecondaryFixed: Color(4281139202),
      secondaryFixedDim: Color(4294947756),
      onSecondaryFixedVariant: Color(4284555293),
      tertiaryFixed: Color(4294957781),
      onTertiaryFixed: Color(4281139201),
      tertiaryFixedDim: Color(4294948010),
      onTertiaryFixedVariant: Color(4285792260),
      surfaceDim: Color(4280094735),
      surfaceBright: Color(4282791220),
      surfaceContainerLowest: Color(4279700234),
      surfaceContainerLow: Color(4280686615),
      surfaceContainer: Color(4280949787),
      surfaceContainerHigh: Color(4281673253),
      surfaceContainerHighest: Color(4282462511),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294965753),
      surfaceTint: Color(4294947756),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294949555),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965753),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4294949555),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965752),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294949552),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4280094735),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294965753),
      outline: Color(4293313471),
      outlineVariant: Color(4293313471),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294434266),
      inversePrimary: Color(4284219398),
      primaryFixed: Color(4294959325),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294949555),
      onPrimaryFixedVariant: Color(4281794562),
      secondaryFixed: Color(4294959325),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4294949555),
      onSecondaryFixedVariant: Color(4281729539),
      tertiaryFixed: Color(4294959324),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294949552),
      onTertiaryFixedVariant: Color(4281794561),
      surfaceDim: Color(4280094735),
      surfaceBright: Color(4282791220),
      surfaceContainerLowest: Color(4279700234),
      surfaceContainerLow: Color(4280686615),
      surfaceContainer: Color(4280949787),
      surfaceContainerHigh: Color(4281673253),
      surfaceContainerHighest: Color(4282462511),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
