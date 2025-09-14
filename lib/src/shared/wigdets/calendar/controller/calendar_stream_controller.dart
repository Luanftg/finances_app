part of '../../widgets.dart';

class CalendarStreamController {
  late StreamController<CalendarState> _calendarController;
  Stream<CalendarState> get calendarStream => _calendarController.stream;

  CalendarStreamController() {
    _calendarController = StreamController<CalendarState>.broadcast();
    _calendarController.sink.add(_state);
  }

  final CalendarState _state = CalendarState(currentMonth: DateTime.now());

  CalendarState get state => _state;

  void dispose() {
    _calendarController.close();
  }

  void toggleDateSelection(DateTime dateEntity) {
    final CalendarState newState = _state.toggleDateSelection(dateEntity);
    updateCalendarState(newState);
  }

  void updateCalendarState(CalendarState newState) {
    _calendarController.sink.add(newState);
  }
}
