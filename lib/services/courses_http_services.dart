import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/course.dart';
import 'package:http/http.dart' as http;

class CoursesHttpServices {
  Future<List<Course>> getCourses() async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/courses.json");

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      List<Course> courses = [];
      if (data != null) {
        data.forEach((key, value) {
          courses.add(
            Course(
              id: key,
              title: value['title'],
              description: value['description'],
              imageUrl: value['imageUrl'],
              lessons: value['lessons'] == null
                  ? []
                  : value['lessons'].cast<String>(),
              price: value['price'].toDouble(),
            ),
          );
        });
      }

      return courses;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  Future<void> addCourse({
    required String title,
    required String description,
    required String imageUrl,
    required double price,
  }) async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/courses.json");

    try {
      final courseData = {
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "lessons": [],
      };
      final response = await http.post(
        url,
        body: jsonEncode(courseData),
      );
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (data != null) {
        courseData['id'] = data['name'];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> addLessonsToCourse(String id, List<String> lessonIds) async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/courses/$id.json");

    try {
      final courseData = {
        "lessons": lessonIds,
      };
      final response = await http.patch(
        url,
        body: jsonEncode(courseData),
      );
      final data = jsonDecode(response.body);
      print(data);
    } catch (e) {
      print(e);
    }
  }
}