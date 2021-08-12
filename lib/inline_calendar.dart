library inline_calendar;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inline_calendar/src/calendar_captions_row.dart';
import 'package:inline_calendar/src/calendar_page_view.dart';
import 'package:inline_calendar/src/cubit/calendar_cubit.dart';
import 'dart:ui';

export 'package:inline_calendar/src/cubit/calendar_cubit.dart';

class InlineCalendar extends StatelessWidget implements PreferredSizeWidget {
  // Maximum weeks to render
  final int maxWeeks = 12;
  final void Function(DateTime)? onChange;
  final CalendarCubit? controller;

  /// Creates an inline vertical calendar widget.
  InlineCalendar({
    Key? key,
    this.onChange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final controller = this.controller;
    if (controller == null) {
      return BlocProvider(
        create: (_) => CalendarCubit(),
        child: _buildInlineCalendar(locale, context),
      );
    }

    return BlocProvider.value(
      value: controller,
      child: _buildInlineCalendar(locale, context),
    );
  }

  Column _buildInlineCalendar(Locale locale, BuildContext context) {
    return Column(
      children: [
        CalendarCaptionsRow(
          key: key,
          middleWeekday: locale.countryCode == 'IR' ? 2 : 4,
          locale: locale,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width / 7
              : MediaQuery.of(context).size.height / 7,
        ),
        CalendarPageView(
          key: key,
          onChange: this.onChange,
          maxWeeks: this.maxWeeks,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width / 7
              : MediaQuery.of(context).size.height / 7,
          middleWeekday: locale.countryCode == 'IR' ? 2 : 4,
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    final pixelRatio = window.devicePixelRatio;
    final logicalScreenSize = window.physicalSize / pixelRatio;
    final logicalWidth = logicalScreenSize.width;
    final logicalHeight = logicalScreenSize.height;
    final smallerSize =
        logicalHeight < logicalWidth ? logicalHeight : logicalWidth;
    return Size.fromHeight((smallerSize / 7) * 2.1);
  }
}
