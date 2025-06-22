import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const WeeklyCalendar({required this.onDateSelected});

  @override
  State<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  DateTime _focusedDate = DateTime.now();

  List<DateTime> _getWeekDates(DateTime focused) {
    final startOfWeek = focused.subtract(Duration(days: focused.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  void _goToPreviousWeek() {
    setState(() {
      _focusedDate = _focusedDate.subtract(Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _focusedDate = _focusedDate.add(Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(_focusedDate);
    final monthYear = DateFormat('MMMM yyyy').format(_focusedDate);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Month Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(monthYear, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 16),
                      onPressed: _goToPreviousWeek,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: _goToNextWeek,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            /// Week Days
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDates.map((date) {
                final isSelected = DateUtils.isSameDay(date, _focusedDate);
                return GestureDetector(
                  onTap: () {
                    setState(() => _focusedDate = date);
                    widget.onDateSelected(date);
                  },
                  child: Column(
                    children: [
                      Text(DateFormat.E().format(date)[0], style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green.shade300 : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
