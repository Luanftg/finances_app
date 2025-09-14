part of 'extension.dart';

extension MinuteExtension on int {
  String roundMinute() {
    if (this ~/ 10 == 0) {
      return '${this}0';
    }
    return '$this';
  }
}
