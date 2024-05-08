import 'package:flutter/material.dart';
import 'package:flutter_app_todo/todo.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  //Basic HomePage Layout of my app
  final TextEditingController _taskItemController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  static List<TaskItem> taskItems = [];

  void saveTaskToList(taskName) {
    MaximumTasksPending.maxLimit++;
    setState(() {
      taskItems.add(TaskItem(
          taskName: taskName,
          taskIndex: taskItems.length + 1,
          isCompleted: false,
          colorSelected: pickerColor));
    });
  }

  getTotalPendingTasks(TaskItems) {
    int total = 0;
    for (var item in taskItems) {
      if (item.isCompleted == false) {
        total = total + 1;
      }
    }
    return total;
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget _buildTasksList() {
    if (taskItems.length != 0) {
      // MaximumTasksPending.maxLimit = getTotalPendingTasks(taskItems);
      return ListView.builder(
          shrinkWrap: true,
          itemCount: taskItems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return TaskItem(
              taskName: taskItems[index].taskName,
              taskIndex: index,
              isCompleted: taskItems[index].isCompleted,
              colorSelected: taskItems[index].colorSelected,
            );
          });
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Dos"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: pickerColor),
                  controller: _taskItemController,
                  onChanged: (text) {},
                  validator: (value) {
                    if (MaximumTasksPending.maxLimit >= 20) {
                      return 'Cannot have more than 20 unfinished tasks.';
                    } else if (value == null || value.isEmpty) {
                      return 'Task cannot be empty.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter task to do.",
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          child: Text("Save",
                              style: TextStyle(color: pickerColor)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveTaskToList(_taskItemController.text);
                              _taskItemController.clear();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.color_lens, color: pickerColor),
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  //Color Picker code
                                  AlertDialog(
                                titlePadding: const EdgeInsets.all(0.0),
                                contentPadding: const EdgeInsets.all(0.0),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: currentColor,
                                    onColorChanged: changeColor,
                                    colorPickerWidth: 300.0,
                                    pickerAreaHeightPercent: 0.7,
                                    enableAlpha: true,
                                    displayThumbColor: true,
                                    showLabel: true,
                                    paletteType: PaletteType.hsv,
                                    pickerAreaBorderRadius:
                                        const BorderRadius.only(
                                      topLeft: const Radius.circular(2.0),
                                      topRight: const Radius.circular(2.0),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                _buildTasksList(),
              ]),
        ),
      ),
    );
  }
}

class MaximumTasksPending {
  static var maxLimit = 0; //For keeping track of total tasks
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
