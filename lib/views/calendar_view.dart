import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to hold the condition for each day
  final Map<DateTime, String> _dayConditions = {
    DateTime(2024, 11, 24): 'poor',
    DateTime(2024, 11, 25): 'good',
    DateTime(2024, 11, 26): 'poor',
    DateTime(2024, 11, 23): 'okay',
  };

  // Define colors for each condition
  final Map<String, Color> _conditionColors = {
    'good': Colors.green,
    'okay': Colors.orange,
    'poor': Colors.red,
  };

  // Event loader to fetch condition for a day
  String? _getConditionForDay(DateTime day) {
    // format the day to only include year, month, and day
    DateTime formatDay = DateTime(day.year, day.month, day.day);
    return _dayConditions[formatDay];
  }

  void addConditionForDay(DateTime day, String condition) {
    DateTime formatDay = DateTime(day.year, day.month, day.day);
    _dayConditions[formatDay] = condition;
  }

Widget _buildKeySection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Key:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 8),

      Row(
        children: [
          // Key for "Today"
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Today',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Key for "Good"
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Good',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Key for "Okay"
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Okay',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Key for "Poor"
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Poor',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context), // Navigate back to main page
        ),
        title: const Text('Melon Health History'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Update focusedDay too
              });
            },
            calendarFormat: CalendarFormat.month,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // Get the condition for the current day
                String? condition = _getConditionForDay(day);

                if (condition != null) {
                  // If the day has a condition, apply the corresponding color
                  return Container(
                    decoration: BoxDecoration(
                      color: _conditionColors[condition], // Use the condition's color
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white), // White text for colored days
                    ),
                  );
                }

                // Default rendering for days without conditions
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.black), // Black text for default days
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          ),
          const SizedBox(height: 16),
          _buildKeySection(),
          const SizedBox(height: 16),
        ],
      )
    );
  }
}
