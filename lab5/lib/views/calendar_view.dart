import 'package:flutter/material.dart';
import 'package:lab5/model/exam.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final List<Exam> exams;

  const CalendarView({Key? key, required this.exams}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Exam> _selectedExams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime(DateTime.now().year + 5),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: (day) {
              // Load events for the specified day
              return widget.exams
                  .where((exam) => isSameDay(exam.dateTime, day))
                  .toList();
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedExams = widget.exams
                      .where((exam) => isSameDay(exam.dateTime, selectedDay))
                      .toList();
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedExams.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(_selectedExams[index].name),
                    subtitle: Text(
                        "Time: ${_selectedExams[index].dateTime.hour}:${_selectedExams[index].dateTime.minute}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
