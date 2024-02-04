import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab5/model/exam.dart';
import 'package:lab5/widgets/location_choose.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class NewExam extends StatefulWidget {
  final Function addExam;

  const NewExam({Key? key, required this.addExam}) : super(key: key);

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _nameController = TextEditingController();
  DateTime? _selectedDateTime;
  LatLong? _location;

  void updateLocation(LatLong newValue) {
    setState(() {
      _location = newValue;
    });
  }

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
                labelText: "Date & Time",
                border: OutlineInputBorder(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateTime == null
                        ? "Date & Time"
                        : _formattedDateTime(),
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          OutlinedButton(
            child: Text(locationString()),
            onPressed: () {
              Navigator.push(context, _createRouteLocationPick());
            },
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

    if (name.isEmpty || _selectedDateTime == null || _location == null) return;

    final newExam = Exam(Random().nextInt(15), name, _selectedDateTime!,
        _location!.longitude, _location!.latitude);

    widget.addExam(newExam);
    Navigator.of(context).pop();
  }

  Route _createRouteLocationPick() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          LocationChoose(updateLocation),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String locationString() {
    if (_location == null) {
      return "Choose location";
    }
    return "${_location?.latitude} ${_location?.longitude}";
  }
}
