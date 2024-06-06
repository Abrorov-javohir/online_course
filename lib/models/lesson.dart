import 'package:flutter_application_1/models/quiz.dart';

class Lesson {
  String id;
  String title;
  String description;
  String videoUrl;
  List<Test> quizes;
  String courseId;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.quizes,
    required this.courseId,
  });
}
