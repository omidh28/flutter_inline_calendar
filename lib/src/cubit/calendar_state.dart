part of 'calendar_cubit.dart';

@immutable
class CalendarState {
  final DateTime selectedDate;
  final Map<DateTime, Color> coloredDates;

  CalendarState({
    required this.selectedDate,
    this.coloredDates = const {},
  });
}
