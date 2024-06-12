import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/views/lessons/add_lesson_screen.dart';

class CourseDetails extends StatefulWidget {
  final Course course;

  const CourseDetails({super.key, required this.course});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                widget.course.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.course.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.course.description,
            ),
            const SizedBox(height: 10),
            const Text(
              "Darslar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.course.lessons.isEmpty
                ? const Text("Darslar mavjud emas")
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.course.lessons.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text("Dars - ${index + 1}"),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return AddLessonScreen(
                        course: widget.course,
                      );
                    },
                  ),
                );
                setState(() {
                  // Trigger a rebuild to show the updated lessons
                });
              },
              child: const Text("Dars qo'shish"),
            ),
          ],
        ),
      ),
    );
  }
}
