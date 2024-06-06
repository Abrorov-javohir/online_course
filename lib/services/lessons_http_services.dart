import 'dart:convert';

import 'package:flutter_application_1/models/lesson.dart';
import 'package:http/http.dart' as http;

class LessonsHttpServices {
  Future<List<Lesson>> getLessons() async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/lessons.json");

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
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
    } catch (e) {
      print(e);
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
        body: jsonEncode(lessonData),
      );
      final data = jsonDecode(response.body);
      if (data != null) {
        lessonData['id'] = data['name'];
        return data['name'];
      }
    } catch (e) {
      print(e);
    }
  }
}