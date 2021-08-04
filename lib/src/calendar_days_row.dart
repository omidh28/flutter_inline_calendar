import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/calendar_day_tile.dart';
import 'package:inline_calendar/src/cubit/calendar_cubit.dart';
import 'package:inline_calendar/src/utilities.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarDaysRow extends StatelessWidget {
  final DateTime middleDate;
  final bool isShamsi;
  final int pageNumber;
  final Locale locale;
  final void Function(DateTime)? onChange;

  CalendarDaysRow({
    Key? key,
    required this.middleDate,
    required this.isShamsi,
    required this.pageNumber,
    required this.locale,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildDayTiles(locale, context),
    );
  }

  List<CalendarDayTile> _buildDayTiles(
    Locale locale,
    BuildContext context,
  ) {
    List<CalendarDayTile> tiles = [];
    for (int i = 0; i < 7; i++) {
      final DateTime dateTime = safeAdd(middleDate, Duration(days: i - 3));
      final Jalali shamsiDate = Jalali.fromDateTime(dateTime);
      final String gregorianMonthLable =
          DateFormat.MMM(locale.toLanguageTag()).format(dateTime);
      final String shamsiMonthLable = shamsiDate.formatter.mN;
      final String monthLable =
          isShamsi ? shamsiMonthLable : gregorianMonthLable;
      final int dayOfMonth = isShamsi ? shamsiDate.day : dateTime.day;
      final bool isFirstDayOfMonth = dayOfMonth == 1;
      final CalendarDayTile tile = CalendarDayTile(
        onTap: () {
          context.read<CalendarCubit>().selectedDate = dateTime;
          final onChange = this.onChange;
          if (onChange != null) {
            onChange(dateTime);
          }
        },
        monthDay: dayOfMonth,
        isToday: isSameDate(dateTime, DateTime.now()),
        tileDate: removeTimeFrom(dateTime),
        title: isFirstDayOfMonth ? monthLable : '',
      );

      tiles.add(tile);
    }

    return tiles;
  }
}
