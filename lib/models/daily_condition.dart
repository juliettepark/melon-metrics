import 'package:isar/isar.dart';

part 'daily_condition.g.dart';

@collection
class DailyCondition {
  Id? id;

  late DateTime date; // The date for the condition
  late String condition; // Health condition (e.g., 'good', 'okay', 'poor')
}
