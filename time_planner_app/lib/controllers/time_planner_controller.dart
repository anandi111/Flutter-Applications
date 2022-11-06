import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_planner_app/modals/task.dart';

Database? db;

class TimePlannerController extends GetxController {
  RxString dayValue = "November 1, 2022".obs;
  RxInt hourValue = 9.obs;
  RxInt minuteValue = 5.obs;
  TextEditingController minutesDurationController = TextEditingController();
  TextEditingController daysDurationController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  RxList taskList = [].obs;

  Future<Database?> initDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'time_planner_database.db');

    // open the database
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE tasks (id INTEGER , day INTEGER, hour INTEGER, minute INTEGER, minutesDuration INTEGER, daysDuration INTEGER, task TEXT);');
    });

    return db!;
  }

  Future<int> addingTask({required Task task, required int id}) async {
    db = await initDB();

    String query =
        "INSERT INTO tasks (id, day, hour, minute, minutesDuration, daysDuration, task) VALUES(?, ?, ?, ?, ?, ?, ?);";

    List args = [
      id,
      task.day,
      task.hour,
      task.minute,
      task.minutesDuration,
      task.daysDuration,
      task.task,
    ];

    return await db!.rawInsert(query, args);
  }

  Future<List<Map<String, Object?>>> fetchingAllTasks() async {
    db = await initDB();

    String query = "SELECT * FROM tasks;";

    List<Map<String, Object?>> allTaskList = await db!.rawQuery(query);

    allTaskList.map((e) => taskList.value.add(e)).toList();

    print(taskList.value);
    print(taskList.value.length);
    print(taskList.value[0]["task"]);

    return allTaskList;
  }

  Future<int> deletingTask({required String task, required int hour}) async {
    db = await initDB();

    String query = "DELETE FROM tasks WHERE task= ? AND hour = ?;";

    List args = [task, hour];

    return await db!.rawDelete(query, args);
  }

  List<String> daysInMonth() {
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;

    DateTime now = DateTime.now();
    int daysCount = DateTime(now.year, now.month + 1, 0).day;

    List<String> days = [];
    for (int i = 1; i < daysCount + 1; i++) {
      days.add(DateFormat(DateFormat.YEAR_MONTH_DAY)
          .format(DateTime(currentYear, currentMonth, i)));
    }
    // print(days);

    return days;
  }
}
