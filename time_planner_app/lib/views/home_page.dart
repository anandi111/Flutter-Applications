import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_planner/time_planner.dart';
import 'package:time_planner_app/controllers/time_planner_controller.dart';
import 'package:time_planner_app/views/add_task_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimePlannerController timePlannerController =
      Get.put(TimePlannerController());
  List<Color?> colors = [
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.lime[600]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: timePlannerController.fetchingAllTasks(),
        builder: (context, snapshot) {
          List<Map<String, Object?>> dataVar =
              snapshot.data as List<Map<String, Object?>>;
          return Center(
              child: TimePlanner(
            startHour: 9,
            endHour: 19,
            style: TimePlannerStyle(
              // cellHeight: 60,
              // cellWidth: 60,
              showScrollBar: true,
            ),
            currentTimeAnimation: true,
            headers: timePlannerController
                .daysInMonth()
                .map((e) => TimePlannerTitle(
                      dateStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      date: e,
                      title: "",
                    ))
                .toList(),
            tasks: List.generate(
              dataVar.length,
              (i) => TimePlannerTask(
                color: colors[Random().nextInt(colors.length)],
                dateTime: TimePlannerDateTime(
                    day: int.parse(dataVar[i]["day"].toString()),
                    hour: int.parse(dataVar[i]["hour"].toString()),
                    minutes: int.parse(dataVar[i]["minute"].toString())),
                minutesDuration:
                    int.parse(dataVar[i]["minutesDuration"].toString()),
                daysDuration: int.parse(dataVar[i]["daysDuration"].toString()),
                child: GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            height: 220,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Delete Task",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const Text(
                                  "Delete 1 item?",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () async {
                                          timePlannerController.deletingTask(
                                              task:
                                                  dataVar[i]["task"].toString(),
                                              hour: int.parse(dataVar[i]["hour"]
                                                  .toString()));
                                          Get.to(() => const MyHomePage(
                                              title: "Time Planner"));
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            dataVar[i]["task"].toString(),
                            style: TextStyle(
                                color: Colors.grey[350], fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddTaskPage());
          // _addObject(context);
        },
        tooltip: 'Add random task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
