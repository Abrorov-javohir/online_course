import 'dart:convert';
import 'package:flutter_application_1/models/lesson.dart';
import 'package:http/http.dart' as http;

class LessonsHttpServices {
  Future<List<Lesson>> getLessons() async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/lessons.json");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>?;
        List<Lesson> lessons = [];
        if (data != null) {
          data.forEach((key, value) {
            lessons.add(
              Lesson(
                id: key,
                courseId: value['courseId'],
                title: value['title'],
                description: value['description'],
                videoUrl: value['videoUrl'],
                quizes: [],
              ),
            );
          });
        }
        return lessons;
      } else {
        print('Error fetching lessons: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lessons: $e');
    }

    return [];
  }

  Future<String?> addLesson({
    required String title,
    required String description,
    required String videoUrl,
    required String courseId,
  }) async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/lessons.json");

    try {
      final lessonData = {
        "title": title,
        "description": description,
        "videoUrl": videoUrl,
        "courseId": courseId,
        "quizes": [],
      };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(lessonData),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          return data['name'];
        }
      } else {
        print('Error adding lesson: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding lesson: $e');
    }
    return null;
  }
}
