part of 'extension.dart';

extension MonthExtension on String {
  int get monthFromString {
    switch (this) {
      case 'Jan':
        return 1;
      case 'Fev':
        return 2;
      case 'Mar':
        return 3;
      case 'Abr':
        return 4;
      case 'Mai':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Ago':
        return 8;
      case 'Set':
        return 9;
      case 'Out':
        return 10;
      case 'Nov':
        return 11;
      case 'Dez':
        return 12;
      default:
        return 1;
    }
  }
}
