part of design;

class AppCustomColors {
  static AppCustomColors? _instance;
  AppCustomColors._();

  static AppCustomColors get i => _instance ??= AppCustomColors._();

  Color get primary => const Color(0xffE4BD48);
  Color get primaryDark => const Color(0xff856914);
  Color get green => const Color(0xff90EF99);
  Color get red => const Color(0xffDF4848);
  Color get logOut => const Color(0xffF2B8B5);
  Color get black => const Color(0xff000000);
  Color get white => const Color(0xffE6E6E6);
  Color get whiteOpacity => const Color(0xffE6E6E6).withOpacity(0.6);
  Color get gray900 => const Color(0xff303030);
  Color get gray800 => const Color(0xff3F3F3F);
  Color get gray700 => const Color(0xff6C6C6C);
  Color get gray600 => const Color(0xff898989);
  Color get gray500 => const Color(0xffA0A0A0);
  Color get gray400 => const Color(0xffB3B3B3);
  Color get gray300 => const Color(0xffE1E1E1);
  Color get gray200 => const Color(0xffE1E1E1);
  Color get gray100 => const Color(0xffEDEDED);
  Color get gray50 => const Color(0xffF9F9F9);
  Color get grayteste => const Color(0xffC4C4C4);
  Color get onSurface => const Color(0xffCCCCCC);
  Color get primaryLight => const Color(0xffFFEEFF);
  Color get inputBorderColor => const Color(0xffB3B3B3);
  Color get linearGradientBAB1 => const Color(0xff222222);
  Color get linearGradientBAB2 => const Color(0xff000000);
  Color get linearGradientWhite => const Color(0xffffffff);
  Color get linearGradientBlack => const Color(0xff010101);
  Color get transparent => Colors.transparent;

  LinearGradient get linearGradientTopStartMid => LinearGradient(
        // tileMode: TileMode.mirror,
        colors: [
          linearGradientBAB1,
          // linearGradientBlack,
          gray800,
          linearGradientBAB1,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  RadialGradient get radialGradient => RadialGradient(
        tileMode: TileMode.decal,
        colors: [linearGradientWhite, linearGradientBlack],
        center: const Alignment(1.0, 1.0),
        focal: Alignment.bottomRight,
        // focalRadius: 1,
      );
  SweepGradient get sweepGradientBAB =>
      SweepGradient(colors: [linearGradientBAB1, white, linearGradientBAB2]);
}

extension AppCustomcolorsExtensions on BuildContext {
  AppCustomColors get colors => AppCustomColors.i;
}
