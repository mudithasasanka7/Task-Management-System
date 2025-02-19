import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_entry_screen.dart'; 
import 'screens/project_management_screen.dart';
import 'screens/task_management_screen.dart'; // Import Task Management Screen

void main() {
  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Initial screen
      routes: {
        '/addEntry': (context) => AddEntryScreen(),
        '/projectManagement': (context) => ProjectManagementScreen(),
        '/taskManagement': (context) => TaskManagementScreen(), // Added Task Management route
      },
    );
  }
}
