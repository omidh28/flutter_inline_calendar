import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:inline_calendar/src/calendar_caption_tile.dart';
import 'package:inline_calendar/src/utilities.dart';

class CalendarCaptionsRow extends StatelessWidget {
  final double height;
  final int middleWeekday;
  final Locale locale;

  const CalendarCaptionsRow({
    Key? key,
    required this.middleWeekday,
    required this.locale,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildCaptionTiles(locale, context),
      ),
      height: this.height,
    );
  }

    List<Widget> _buildCaptionTiles(Locale locale, BuildContext context) {
    List<Widget> tiles = [];
    DateTime middleDate = DateTime.now();
    while (middleDate.weekday != middleWeekday) {
      middleDate = safeAdd(middleDate, Duration(days: 1));
    }

    for (int i = 0; i < 7; i++) {
      final String abbrWeekName = DateFormat.E(locale.toLanguageTag()).format(
        safeAdd(middleDate, Duration(days: i - 3)),
      );

      tiles.add(CalendarCaptionTile(
        lable: locale.languageCode.startsWith('ar')
            ? abbrWeekName
            : abbrWeekName[0],
        color: _weekdayNameColor(context),
      ));
    }

    return tiles;
  }

  Color _weekdayNameColor(BuildContext context) {
    return Theme.of(context).appBarTheme.brightness == Brightness.dark
        ? Colors.black87
        : Colors.white;
  }
}
