import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab3/model/exam.dart';

class NewExam extends StatefulWidget {
  final Function addExam;

  const NewExam({Key? key, required this.addExam}) : super(key: key);

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _nameController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submitData(),
          ),
          const SizedBox(height: 12.0),
          InkWell(
            onTap: () => _pickDateTime(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                //labelText: "Date & Time",
                border: OutlineInputBorder(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateTime == null
                        ? "Select Date & Time"
                        : _formattedDateTime(),
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text(
              "Add Exam",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  void _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  String _formattedDateTime() {
    return "${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} ${_selectedDateTime!.hour}:${_selectedDateTime!.minute}";
  }

  void _submitData() {
    final name = _nameController.text.trim();

    if (name.isEmpty || _selectedDateTime == null) return;

    final newExam = Exam(Random().nextInt(15), name, _selectedDateTime!);

    widget.addExam(newExam);
    Navigator.of(context).pop();
  }
}
