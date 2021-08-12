import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/utilities.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  static const centralPage = 6;
  final PageController pageController =
      PageController(initialPage: centralPage);

  /// Creates a controller for an inline calendar.
  CalendarCubit() : super(CalendarState(selectedDate: DateTime.now()));

  set selectedDate(DateTime selectedDate) {
    emit(CalendarState(
      selectedDate: selectedDate,
      coloredDates: state.coloredDates,
    ));
    pageController.jumpToPage(centralPage);
  }

  set coloredDates(Map<DateTime, Color> coloredDates) => emit(
        CalendarState(
          coloredDates: coloredDates
              .map((key, value) => MapEntry(removeTimeFrom(key), value)),
          selectedDate: state.selectedDate,
        ),
      );

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
