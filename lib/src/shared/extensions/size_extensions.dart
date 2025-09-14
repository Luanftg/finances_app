part of 'extension.dart';

extension SizeExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percenteWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;
  double percentHeightReferenced(double percent) =>
      screenHeight * (percent / 932);
  double percentWidthReferenced(double percent) =>
      screenHeight * (percent / 430);
}
