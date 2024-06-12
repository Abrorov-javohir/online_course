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
    try {
      final response = await lessonsHttpServices.addLesson(
        title: title,
        description: description,
        videoUrl: videoUrl,
        courseId: courseId,
      );

      // Assuming response is successful and contains the new lesson's ID or relevant data
      if (response != null) {
        // Optionally, you could add the new lesson to the local _list
        // final newLesson = Lesson(
        //   id: response, // or use proper ID from response
        //   title: title,
        //   description: description,
        //   videoUrl: videoUrl,
        //   courseId: courseId,
        // );
        // _list.add(newLesson);
      }

      return response;
    } catch (e) {
      // Handle errors accordingly
      print('Error adding lesson: $e');
      return null;
    }
  }
}
