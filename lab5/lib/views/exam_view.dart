import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab5/constants/routes.dart';
import 'package:lab5/model/exam.dart';
import 'package:lab5/views/calendar_view.dart';
import 'package:lab5/views/map_view.dart';
import 'package:lab5/widgets/exam_list.dart';
import 'package:lab5/widgets/new_exam.dart';

enum MenuAction {
  exams,
  calendar,
  addExam,
  logout,
  login,
}

class ExamView extends StatefulWidget {
  const ExamView({Key? key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  final List<Exam> _exams = [];
  int _selectedIndex = 0;

  late User? _user;

  @override
  void initState() {
    super.initState();
    // authStateChanges() is used to detect
    // changes to the user's sign-in state (such as sign-in or sign-out)
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  void _addExamFunction() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          // NewExam is a custom widget
          child: NewExam(addExam: _addNewExam),
        );
      },
    );
  }

  void _addNewExam(Exam value) {
    setState(() {
      _exams.add(value);
    });
  }

  void _deleteExam(int index) {
    setState(() {
      _exams.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Page"),
        backgroundColor: Colors.blueGrey,
        actions: [
          PopupMenuButton<MenuAction>(
            itemBuilder: (context) {
              return _buildPopupMenuItems();
            },
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  break;
                case MenuAction.addExam:
                  _addExamFunction();
                  break;
                case MenuAction.login:
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  break;
                case MenuAction.calendar:
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(calendarRoute, (route) => false);
                  break;
                case MenuAction.exams:
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil(examsRoute, (route) => false);
                  break;
              }
            },
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: _buildBody()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Your Exams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Your Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: (index) => {
          setState(() {
            _selectedIndex = index;
          })
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ExamList(exams: _exams, onDelete: _deleteExam);
      case 1:
        return CalendarView(exams: _exams);
      case 2:
        return MapView(long: -1, lat: -1, exams: _exams);
      default:
        return Container();
    }
  }

  List<PopupMenuEntry<MenuAction>> _buildPopupMenuItems() {
    if (_user == null) {
      return [
        const PopupMenuItem<MenuAction>(
          value: MenuAction.login,
          child: ListTile(
            leading: Icon(Icons.login),
            title: Text(
              "Log In",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];
    } else {
      return [
        const PopupMenuItem<MenuAction>(
          value: MenuAction.addExam,
          child: ListTile(
            leading: Icon(
              Icons.assignment_add,
              color: Colors.blue,
            ),
            title: Text(
              "Add Exam",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const PopupMenuItem<MenuAction>(
          value: MenuAction.logout,
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];
    }
  }

  Future<bool> showLogOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text("Sign out"),
          content: const Text("Are you sure you want to sign out?"),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          actions: [
            SizedBox(
              width: double.infinity, // Make the container take the full width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      "Log out",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
