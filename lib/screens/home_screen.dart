import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> timeEntries = []; // Store time entries

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Function to add new entry
  void addTimeEntry(Map<String, String> entry) {
    setState(() {
      timeEntries.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Projects'),
            Tab(text: 'Tasks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Projects Tab
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_open, // Folder icon for empty state
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  'No projects added yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addEntry').then((newEntry) {
                      if (newEntry != null) {
                        addTimeEntry(newEntry as Map<String, String>);
                      }
                    });
                  },
                  child: Text('Add Your First Project'),
                ),
              ],
            ),
          ),
          // Tasks Tab
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt, // Task icon for empty state
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  'No tasks added yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Add Task screen (to be added later)
                  },
                  child: Text('Add Your First Task'),
                ),
              ],
            ),
          ),
          // Time Entries Tab (New tab to display entries)
          ListView.builder(
            itemCount: timeEntries.length,
            itemBuilder: (context, index) {
              final entry = timeEntries[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Project: ${entry['project']}'),
                  subtitle: Text('Task: ${entry['task']}\nDate: ${entry['date']}\nTime: ${entry['time']} hours'),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
