import 'package:flutter/material.dart';

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<String> tasks = []; // List to store tasks
  final TextEditingController _taskController = TextEditingController();

  // Function to show the Add Task dialog
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: "Enter task name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  setState(() {
                    tasks.add(_taskController.text);
                  });
                  _taskController.clear();
                  Navigator.pop(context); // Close dialog after adding
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Management')),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks added yet!"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
