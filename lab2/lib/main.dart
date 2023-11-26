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
      home: const ClothingApp(),
    );
  }
}

class ClothingApp extends StatefulWidget {
  const ClothingApp({super.key});

  @override
  State<ClothingApp> createState() => _ClothingAppState();
}

class _ClothingAppState extends State<ClothingApp> {
  final List<String> _clothing = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '203007',
          style: TextStyle(fontSize: 38.0, fontFamily: AutofillHints.birthday),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
        child: ListView.builder(
          itemCount: _clothing.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  _clothing[index],
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_rounded, color: Colors.green),
                      onPressed: () {
                        editClothingItem(index, _clothing[index]);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _clothing.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addClothingItem,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(255, 226, 221, 221),
        child: SizedBox(
          height: 50.0,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'MIS Lab 2 - Maja Vuevska - 11/2023',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void addClothingItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String newClothingItem = "";
          return AlertDialog(
            title: const Text(
              'Add a new Clothing Item',
              style: TextStyle(color: Colors.blue),
            ),
            content: TextField(
              autofocus: true,
              onChanged: (String value) {
                newClothingItem = value;
              },
            ),
            actions: [
              Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (newClothingItem.isNotEmpty) {
                            _clothing.add(newClothingItem);
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'))),
            ],
          );
        });
  }

  void editClothingItem(int index, String currentClothing) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editingController =
            TextEditingController(text: currentClothing);

        return AlertDialog(
          title: const Text('Edit Clothing Item'),
          content: TextField(
            controller: editingController,
            decoration:
                const InputDecoration(hintText: 'Enter updated clothing item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _clothing[index] = editingController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
