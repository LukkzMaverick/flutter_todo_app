import 'package:flutter/material.dart';
import 'tasks_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/models/task_data.dart';

class TasksList extends StatelessWidget {
  static String _textFieldDialog;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final taskItem = taskData.tasks[index];
            return Dismissible(
              key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
              background: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.startToEnd,
              child: TaskTile(
                taskTitle: taskItem.name,
                isChecked: taskItem.isDone,
                checkboxCallback: (bool) {
                  taskData.updateTask(taskItem);
                },
                longPressCallback: () {
                  _textFieldDialog = taskItem.getName();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Edit Task: ${taskItem.getName()}'),
                          content: TextField(
                            onChanged: (text) {
                              _textFieldDialog = text;
                            },
                            decoration: InputDecoration(hintText: "New Title"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: new Text('CANCEL'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: new Text('Ok'),
                              onPressed: () {
                                taskData.editTask(
                                    taskItem.getToogleIsDone(taskItem),
                                    taskData.getTaskIndex(taskItem),
                                    _textFieldDialog);
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              onDismissed: (direction) {
                taskData.deleteTask(taskItem);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
/*
 */
