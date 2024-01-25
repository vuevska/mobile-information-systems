import 'package:flutter/material.dart';
import 'package:todolist/model/Todo.dart';
import 'package:todolist/widgets/new_todo.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<Todo> _todos = [];

  void _addTodoFunction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTodo(addTodo: _addNewTodoToList),
          );
        });
  }

  void _addNewTodoToList(Todo todo) {
    setState(() {
      _todos.add(todo);
    });
  }

  // void addTodo() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         String newTodo = "";
  //         return AlertDialog(
  //           title: const Text("Add a new To-Do"),
  //           content: TextField(
  //             onChanged: (value) {
  //               newTodo = value;
  //             },
  //           ),
  //           actions: [
  //             ElevatedButton(
  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
  //                 onPressed: () {
  //                   setState(() {
  //                     if (newTodo.isNotEmpty) {
  //                       _todos.add(newTodo);
  //                     }
  //                     Navigator.pop(context);
  //                   });
  //                 },
  //                 child: const Text("Add"))
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () => _addTodoFunction(),
              icon: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  _todos[index].title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple),
                ),
                subtitle: Text(
                  _todos[index].description,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _todos.removeAt(index);
                    });
                  },
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addNewTodoToList,
      //   backgroundColor: Colors.amber,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
