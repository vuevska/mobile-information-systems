import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<String> _courses = [
    'Menagment Information Systems',
    'Team Project',
    'Web Based Systems',
    'Mobile Information Systems',
    'Intro to Smart Cities'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '203007',
              style:
                  TextStyle(fontSize: 38.0, fontFamily: AutofillHints.birthday),
            ),
          ),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_courses[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_rounded, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _courses.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: addCourse,
        child: const Icon(Icons.add_outlined),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(255, 226, 221, 221),
        child: SizedBox(
          height: 50.0,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'MIS Lab 1 - Maja Vuevska - 11/2023',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void addCourse() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String newCourse = "";
          return AlertDialog(
            title: const Text('Add a new Course'),
            content: TextField(
              autocorrect: false,
              autofocus: true,
              onChanged: (String value) {
                newCourse = value;
              },
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    setState(() {
                      if (newCourse.isNotEmpty) {
                        _courses.add(newCourse);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }
}
