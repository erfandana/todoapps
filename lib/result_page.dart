import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'input_page.dart';

class ResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  ResultPage({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make appBar transparent
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false,
        toolbarHeight: 0, // Remove toolbar height
      ),
      body: Column(
        children: [
          // Wave header with green color and some decoration
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(), // Applying wave effect
                child: Container(
                  height: 150,
                  color: Colors.green, // Green wave background
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 40),
                    SizedBox(width: 10),
                    Text(
                      'Task List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'List',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Tanggal',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 2),
                  // Task list
                  tasks.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text('No tasks added yet.'),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              DateTime taskDate = tasks[index]['date'];
                              String formattedDate =
                                  '${taskDate.day}/${taskDate.month}/${taskDate.year}';
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text('${index + 1}')),
                                    Expanded(child: Text(tasks[index]['task'])),
                                    Expanded(child: Text(formattedDate)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating action button to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputPage(tasks: tasks),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Task',
        backgroundColor: Colors.green, // Matching the wave color
      ),
    );
  }
}
