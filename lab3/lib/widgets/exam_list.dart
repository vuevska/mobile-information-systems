import 'package:flutter/material.dart';
import 'package:lab3/model/exam.dart';
import 'package:intl/intl.dart';

class ExamList extends StatelessWidget {
  final List<Exam> exams;
  final void Function(int) onDelete;

  const ExamList({Key? key, required this.exams, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        String formattedDateTime =
            DateFormat('dd-MM-yyyy HH:mm').format(exams[index].dateTime);

        return Card(
          color: Colors.grey,
          elevation: 4.0,
          child: Center(
            child: ListTile(
              title: Text(
                exams[index].name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                formattedDateTime,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
