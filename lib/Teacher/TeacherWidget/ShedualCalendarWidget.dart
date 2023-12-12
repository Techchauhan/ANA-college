import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendarWidget extends StatefulWidget {
  @override
  _ScheduleCalendarWidgetState createState() => _ScheduleCalendarWidgetState();
}

class _ScheduleCalendarWidgetState extends State<ScheduleCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _events = {}; // Events for each day

  TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Schedule/Calendar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
            SizedBox(height: 20.0),
            _buildEventList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Events for ${_selectedDay ?? DateTime.now()}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        if (_selectedDay != null)
          ...(_events[_selectedDay] ?? []).map((event) {
            return ListTile(
              title: Text(event),
              // Add an option to delete an event (you can replace this with editing options)
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _events[_selectedDay]?.remove(event);
                  });
                },
              ),
            );
          }).toList(),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _showAddEventDialog,
          child: Text('Add Event'),
        ),
      ],
    );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: TextField(
            controller: _eventController,
            decoration: InputDecoration(labelText: 'Event Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_eventController.text.isNotEmpty && _selectedDay != null) {
                  setState(() {
                    if (_events[_selectedDay] == null) {
                      _events[_selectedDay!] = [];
                    }
                    _events[_selectedDay]!.add(_eventController.text);
                  });
                  _eventController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
}
