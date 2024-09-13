import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;

  InputPage({required this.tasks});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _taskController = TextEditingController(); // For task input
  final _dateController = TextEditingController(); // For date input
  DateTime? _selectedDate;

  // Function to show date picker and update TextField
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
      });
    }
  }

  // Function to add task and navigate to result page
  void _addTask() {
    if (_taskController.text.isNotEmpty && _selectedDate != null) {
      // Add task to the list
      setState(() {
        widget.tasks.add({
          'task': _taskController.text,
          'date': _selectedDate,
        });
      });

      // Clear input fields
      _taskController.clear();
      _dateController.clear();
      _selectedDate = null;

      // Navigate to ResultPage with updated task list
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(tasks: widget.tasks),
        ),
      );
    }
  }

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
                    Icon(Icons.edit, color: Colors.white, size: 40),
                    SizedBox(width: 10),
                    Text(
                      'Add New Task',
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
                  // Task input field
                  TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Date input field (non-editable, updated via DatePicker)
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Select date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Add Task button
                  ElevatedButton(
                    onPressed: _addTask,
                    child: Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
