import 'package:flutter_application_1/models/course.dart';
import 'package:flutter_application_1/services/courses_http_services.dart';

class CoursesViewmodel {
  final coursesHttpServices = CoursesHttpServices();

  List<Course> _list = [];

  Future<List<Course>> get list async {
    _list = await coursesHttpServices.getCourses();
    return [..._list];
  }

  Future<void> addCourse({
    required String title,
    required String description,
    required String imageUrl,
    required double price,
  }) async {
    await coursesHttpServices.addCourse(
      title: title,
      description: description,
      imageUrl: imageUrl,
      price: price,
    );
    // Update the local list after adding a new course
    _list = await coursesHttpServices.getCourses();
  }

  Future<void> addLessonsToCourse(String id, List<String> lessonIds) async {
    await coursesHttpServices.addLessonsToCourse(id, lessonIds);
    // Update the local list after adding lessons to a course
    _list = await coursesHttpServices.getCourses();
  }

  getList() {}
}
