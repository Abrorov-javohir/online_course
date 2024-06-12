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
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>?;
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
                    : List<String>.from(value['lessons']),
                price: value['price'].toDouble(),
              ),
            );
          });
        }
        return courses;
      } else {
        if (kDebugMode) {
          print('Error fetching courses: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching courses: $e');
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
    Uri url = Uri.parse("https://dars54-default-rtdb.firebaseio.com/");

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
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(courseData),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print('Error adding course: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding course: $e');
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
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(courseData),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print('Error adding lessons to course: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding lessons to course: $e');
      }
    }
  }
}
