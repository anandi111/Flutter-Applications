import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_planner_app/controllers/time_planner_controller.dart';
import 'package:time_planner_app/modals/task.dart';
import 'package:time_planner_app/views/home_page.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TimePlannerController timePlannerController =
      Get.put(TimePlannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Planner"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                timePlannerController.addingTask(
                    task: Task(
                        color: Colors.grey,
                        day: int.parse(timePlannerController.dayValue.value
                                .toString()
                                .split(" ")[1]
                                .split(",")[0]) -
                            1,
                        hour: timePlannerController.hourValue.value,
                        minute: timePlannerController.minuteValue.value,
                        minutesDuration: int.parse(timePlannerController
                            .minutesDurationController.text),
                        daysDuration: int.parse(
                            timePlannerController.daysDurationController.text),
                        task: timePlannerController.taskController.text),
                    id: 1);
                Get.to(() => MyHomePage(title: "Time Planner"));
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Starting Date",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: timePlannerController.dayValue.value,
                                items: timePlannerController
                                    .daysInMonth()
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  timePlannerController.dayValue.value =
                                      val.toString();
                                },
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Starting Hour",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: timePlannerController.hourValue.value,
                                items:
                                    [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e.toString()),
                                              value: e,
                                            ))
                                        .toList(),
                                onChanged: (val) {
                                  timePlannerController.hourValue.value =
                                      int.parse(val.toString());
                                },
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Starting Minutes",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: timePlannerController.minuteValue.value,
                                items: [
                                  00,
                                  05,
                                  10,
                                  15,
                                  20,
                                  25,
                                  30,
                                  35,
                                  40,
                                  45,
                                  50,
                                  55,
                                  60
                                ]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toString()),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  timePlannerController.minuteValue.value =
                                      int.parse(val.toString());
                                },
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Minutes Duration of task",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    TextField(
                      controller:
                          timePlannerController.minutesDurationController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "for example enter 60 for hour.."),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Day Duration of task",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    TextField(
                      controller: timePlannerController.daysDurationController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "for example enter 1 for today.."),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Task",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    TextField(
                      controller: timePlannerController.taskController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "write task.."),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
