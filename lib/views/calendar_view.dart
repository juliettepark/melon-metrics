import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:melon_metrics/providers/health_provider.dart';
import "package:melon_metrics/models/daily_condition.dart";
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {

  final Isar isar;

  const CalendarPage({super.key, required this.isar});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  void initState() {
    super.initState();
    _updateDayConditions(); // Populate the map on initialization
  }

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

  /// Event loader to fetch condition for a day
  /// 
  /// Parameters:
  ///     -day: specific date to fetch condition
  String? _getConditionForDay(DateTime day) {
    // format the day to only include year, month, and day
    DateTime formatDay = DateTime(day.year, day.month, day.day);
    return _dayConditions[formatDay];
  }

  /// Add a new condition 
  void addConditionForDay(DateTime day, String condition) {
    DateTime formatDay = DateTime(day.year, day.month, day.day);
    _dayConditions[formatDay] = condition;
  }

// Displays the keys of the calendar
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue, // Blue border
                    width: 2, // Border width
                  ),
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

/// Updates the calendar with saved conditions of our user
/// 
/// This will pull from our user's history and build a calendar of
/// color coded conditions
Future<void> _updateDayConditions() async {
  // Fetch all saved conditions from the database
  final history = widget.isar.dailyConditions.where().findAllSync();

  // Update the _dayConditions map
  setState(() {
    //_dayConditions.clear(); // Clear existing entries
    for (var entry in history) {
      _dayConditions[DateTime(entry.date.year, entry.date.month, entry.date.day)] = entry.condition;
    }
  });
}

/// Save today's condition of the user
/// 
/// Parameters: 
///     condition: given condition of the user
/// 
/// This will save the user's condition in the isar database for today's 
/// date and return a success message
Future<void> _saveCondition(String condition) async {
  final today = DateTime.now();
  final conditionEntry = DailyCondition()
    ..date = DateTime(today.year, today.month, today.day)
    ..condition = condition;

  await widget.isar.writeTxn(() async {
    // Check if a condition already exists for the same date
    final existingEntry = await widget.isar.dailyConditions
        .filter()
        .dateEqualTo(conditionEntry.date)
        .findFirst();

    if (existingEntry != null) {
      // Update the existing entry
      conditionEntry.id = existingEntry.id;
    }

    // Save (or update) the condition entry
    await widget.isar.dailyConditions.put(conditionEntry);
    /// if you want to clear the isar data for testing
    // await widget.isar.dailyConditions.clear();
    // print("DailyCondition collection cleared.");
  });


  // Update the _dayConditions map
  await _updateDayConditions();

  // Rebuild the calendar to apply the changes
  setState(() {});

  // If page still mounted
  if (!mounted) return;
  
  // Message if saved
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Condition saved for ${DateFormat('yyyy-MM-dd').format(today)}')),
  );
}

/// Determines condition to display based on well being score
/// 
/// Parameter:
///     -score: well being score
String _determineCondition(double score) {
  if (score >= 75.0) {
    return 'good';
  } else if (score >= 40.0) {
    return 'okay';
  } else {
    return 'poor';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics (
          label: 'Health History Calendar',
          child: const Text('Hoot Health History'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Calendar building/formatting
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
                  return Semantics(
                    label: 'Day ${day.day} with $condition',
                    child: Container(
                    decoration: BoxDecoration(
                      color: _conditionColors[condition], // Use the condition's color
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white), // White text for colored days
                      ),
                    )
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
                String? condition = _getConditionForDay(day);
                return Semantics(
                  label: 'Today, Day ${day.day} with ${condition ?? 'no condition'}',
                  child: Container(
                  decoration: BoxDecoration(
                    // Use condition's color if available
                    // Transparent if no condition
                    color: condition != null
                        ? _conditionColors[condition] 
                        : Colors.transparent,       
                    shape: BoxShape.circle,
                    border: condition == null
                        ? Border.all(color: Colors.blueAccent, width: 2) // Outline for today
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: condition != null ? Colors.white : Colors.blueAccent, // Change text color
                    ),
                  ),
                  )
                );
              },
            ),
          ),
          ),
          const SizedBox(height: 16),
          // Button for logging today's well being score
          Semantics(
            label: 'Log today\'s health in calendar',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(116, 84, 106, 1),
                foregroundColor: const Color.fromRGBO(246, 200, 177, 1)
              ),
              onPressed: () async {
                final healthProvider = Provider.of<HealthProvider>(context, listen: false);
                final double wellBeingScore = healthProvider.wellbeingScore; // Get the score
                String condition = _determineCondition(wellBeingScore);
                await _saveCondition(condition);
              },
              child: const Text('Log Today\'s Score'),
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
