import 'package:flutter/material.dart';
import 'main.dart';

Color _selectedColor = Color(0xff443a49);

class TaskItem extends StatefulWidget {
  final String taskName;
  final int taskIndex;
  bool isCompleted;
  Color colorSelected;

  TaskItem(
      {Key? key,
      required this.taskName,
      required this.taskIndex,
      required this.isCompleted,
      required this.colorSelected})
      : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  //Decides layout for each task
  bool? _value = false;
  bool? _completedCheck = false;

  TextDecoration? getTextStyle(BuildContext context) {
    if (!_completedCheck!) return null;

    return TextDecoration.lineThrough;
  }

  Color? getDeleteIconColor(BuildContext context) {
    if (!_completedCheck!) return widget.colorSelected;

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    _selectedColor = widget.colorSelected;
    return Row(
      children: [
        Checkbox(
          activeColor: widget.colorSelected,
          onChanged: (newValue) {
            if (!widget.isCompleted) {
              setState(() => _value = newValue);
            }
          },
          value: _value,
        ),
        Text(widget.taskName,
            style: TextStyle(
                color: widget.colorSelected,
                decoration: getTextStyle(context))),
        Spacer(),
        IconButton(
            onPressed: () {
              if (!widget.isCompleted) {
                setState(() {
                  MyHomePageState.taskItems[widget.taskIndex].isCompleted =
                      true;
                  widget.isCompleted = true;
                  _completedCheck = true;
                  MaximumTasksPending.maxLimit--;
                });
              }
            },
            icon: Icon(
              Icons.delete_outline,
              color: getDeleteIconColor(context),
            ))
      ],
    );

    // return CheckboxListTile(
    //         title: new Text(widget.taskName),
    //         value: _value,
    //         onChanged: (value) {
    //           // setState(() {
    //           //   _value = value;
    //           // });
    //         },
    //         controlAffinity: ListTileControlAffinity.leading,
    //         secondary: IconButton(
    //         onPressed: () {
    //           // final myHome = new MyHomePage();
    //           // myHome.removeTaskFromList(widget.taskIndex);
    //         },
    //         icon: Icon(Icons.delete_outline)
    //         ),
    //       );
  }
}
