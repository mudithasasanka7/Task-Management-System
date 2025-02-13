import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  String? selectedProject;
  String? selectedTask;
  String? selectedDate;

  final List<String> projectList = [
    'Project A',
    'Project B',
    'Project C',
  ];

  final List<String> taskList = [
    'Task 1',
    'Task 2',
    'Task 3',
  ];

  final TextEditingController totalTimeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Time (hours):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: totalTimeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter total time (e.g., 5)',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select a Project:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedProject,
                items: projectList.map((project) {
                  return DropdownMenuItem<String>(
                    value: project,
                    child: Text(project),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProject = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                hint: Text('Choose a project'),
              ),
              SizedBox(height: 20),
              Text(
                'Select a Task:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedTask,
                items: taskList.map((task) {
                  return DropdownMenuItem<String>(
                    value: task,
                    child: Text(task),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTask = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                hint: Text('Choose a task'),
              ),
              SizedBox(height: 20),
              Text(
                'Notes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter any additional notes',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select a Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                  hintText: selectedDate ?? 'Choose a date',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (selectedProject != null &&
                      selectedTask != null &&
                      totalTimeController.text.isNotEmpty &&
                      selectedDate != null) {
                    // Save the new entry and go back to the home screen
                    Map<String, String> newEntry = {
                      'project': selectedProject!,
                      'task': selectedTask!,
                      'date': selectedDate!,
                      'time': totalTimeController.text,
                    };
                    Navigator.pop(context, newEntry); // Return the entry to the home screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill all fields!'),
                    ));
                  }
                },
                child: Text('Submit Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
