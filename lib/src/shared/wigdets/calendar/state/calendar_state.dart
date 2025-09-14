part of '../../widgets.dart';

enum CalendarSelectionMode { single, range, readOnly }

class CalendarState {
  final DateTime currentMonth;
  final Set<DateTime> selectedDates;
  final CalendarSelectionMode selectionMode;
  DateTime? rangeStartDate;
  DateTime? rangeEndDate;

  CalendarState({
    required this.currentMonth,
    Set<DateTime>? selectedDates,
    this.rangeStartDate,
    this.rangeEndDate,
    this.selectionMode = CalendarSelectionMode.single,
  }) : selectedDates = selectedDates ?? {};

  CalendarState toggleDateSelection(DateTime dateEntity) {
    if (selectionMode == CalendarSelectionMode.readOnly) {
      return this;
    }

    final updatedDates = {...selectedDates};
    DateTime? updatedRangeStartDate;
    DateTime? updatedRangeEndDate;

    if (updatedDates.contains(dateEntity)) {
      updatedDates.remove(dateEntity);
    } else {
      if (selectionMode == CalendarSelectionMode.single) {
        updatedDates.clear();
      } else if (rangeStartDate == null ||
          dateEntity.isBefore(rangeStartDate!)) {
        updatedRangeStartDate = dateEntity;
      } else if (rangeEndDate == null || dateEntity.isAfter(rangeEndDate!)) {
        updatedRangeEndDate = dateEntity;
      }
      updatedDates.add(dateEntity);
    }

    return copyWith(
      selectionMode: selectionMode,
      currentMonth: dateEntity,
      selectedDates: updatedDates,
      rangeStartDate: updatedRangeStartDate,
      rangeEndDate: updatedRangeEndDate,
    );
  }

  CalendarState copyWith({
    DateTime? currentMonth,
    Set<DateTime>? selectedDates,
    CalendarSelectionMode? selectionMode,
    DateTime? rangeStartDate,
    DateTime? rangeEndDate,
  }) {
    return CalendarState(
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDates: selectedDates ?? this.selectedDates,
      selectionMode: selectionMode ?? this.selectionMode,
      rangeStartDate: rangeStartDate ?? this.rangeStartDate,
      rangeEndDate: rangeEndDate ?? this.rangeEndDate,
    );
  }
}
