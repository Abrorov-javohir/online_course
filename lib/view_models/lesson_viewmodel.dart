
import 'package:flutter_application_1/models/lesson.dart';
import 'package:flutter_application_1/services/lessons_http_services.dart';

class LessonsViewmodel {
  final lessonsHttpServices = LessonsHttpServices();

  List<Lesson> _list = [];

  List<Lesson> get list {
    return [..._list];
  }

  Future<String?> addLesson({
    required String title,
    required String description,
    required String videoUrl,
    required String courseId,
  }) async {
    // Todo - Yangi kursni yaratish
   return await lessonsHttpServices.addLesson(
      title: title,
      description: description,
      videoUrl: videoUrl,
      courseId: courseId,
    );
  }
}
