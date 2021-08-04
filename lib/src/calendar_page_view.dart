import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/calendar_days_row.dart';
import 'package:inline_calendar/src/cubit/calendar_cubit.dart';
import 'package:inline_calendar/src/utilities.dart';

class CalendarPageView extends StatelessWidget {
  final double height;
  final int maxWeeks;
  final int middleWeekday;
  final void Function(DateTime)? onChange;

  const CalendarPageView({
    Key? key,
    required this.height,
    required this.maxWeeks,
    required this.middleWeekday,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<CalendarCubit>().state.selectedDate;
    // context.read<CalendarCubit>().pageController.jumpToPage(6);
    final selectedDateUtc =
        DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day);
    final firstWeekMiddleDate = _firstWeekMiddleDate(selectedDateUtc);
    final locale = Localizations.localeOf(context);
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: this.height,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: context.read<CalendarCubit>().pageController,
          itemBuilder: (context, index) {
            return CalendarDaysRow(
              middleDate:
                  safeAdd(firstWeekMiddleDate, Duration(days: (index * 7))),
              isShamsi: locale.countryCode == 'IR',
              onChange: this.onChange,
              pageNumber: index,
              locale: Localizations.localeOf(context),
            );
          },
          itemCount: maxWeeks + 1,
        ),
      ),
    );
  }

  DateTime _firstWeekMiddleDate(DateTime baseDate) {
    final DateTime middleDate = safeAdd(
      baseDate,
      Duration(days: middleWeekday - baseDate.weekday),
    );

    return safeSubtract(middleDate, Duration(days: (7 * maxWeeks ~/ 2)));
  }
}
