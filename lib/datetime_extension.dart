extension DateTimeFormat on DateTime {
  String get onlyDate {
    final String day = this.day < 10 ? '0${this.day}' : '${this.day}';
    final String month = this.month < 10 ? '0${this.month}' : '${this.month}';
    return '$day/$month/$year';
  }
}
