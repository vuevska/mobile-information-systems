import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/model/Todo.dart';

class NewTodo extends StatefulWidget {
  final Function addTodo;

  const NewTodo({super.key, required this.addTodo});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
            onSubmitted: (_) => _submitData,
          ),
          ElevatedButton(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              child: const Text(
                "Submit your activity!",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  void _submitData() {
    if (_titleController.text.isEmpty) return;
    final inputTitle = _titleController.text;
    final inputDesc = _descriptionController.text;
    if (inputTitle.isEmpty || inputDesc.isEmpty) return;

    final newTodo = Todo(Random().nextInt(15), inputTitle, inputDesc, false);

    widget.addTodo(newTodo);
    Navigator.of(context).pop();
  }
}
