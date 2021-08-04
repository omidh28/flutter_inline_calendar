# inline_calendar

An inline calendar flutter package inspired by outlook app. It also supports Jalali/Shamsi calendar.

Uses theme and locale of context to localize and change color of widgets.

<img src="https://github.com/omidh28/flutter_inline_calender/blob/master/screenshots/screenshot_01.png?raw=true" height="500">


## Usage

Add the module to your project ``pubspec.yaml`` then install it using ``flutter packages get`


``` yaml
...
dependencies:
 ...
 inline_calendar: ^0.0.1
...
```

**Example:**

``` Dart
import 'package:flutter/material.dart';
import 'package:inline_calendar/inline_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CalendarCubit _controller;
  Map<DateTime, Color> _coloredDates = {
    DateTime.now().add(Duration(days: 2)): Colors.blue,
    DateTime.now().subtract(Duration(days: 7)): Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.selectedDate =
                _controller.state.selectedDate.add(Duration(days: 1));
          },
          child: Text('Add a Day'),
        ),
        appBar: AppBar(
          title: Text('Inline Calendar'),
          bottom: InlineCalendar(
            controller: _controller,
            onChange: (DateTime d) => print(d),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = CalendarCubit();
    _controller.coloredDates = _coloredDates;
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _controller.close();
    super.dispose();
  }
}
```