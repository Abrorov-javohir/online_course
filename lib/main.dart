import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/views/courses/add_course_screen.dart';
import 'package:flutter_application_1/views/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.mainScreen,
      routes: {

        RouteNames.mainScreen: (ctx) => const MainScreen(),
        RouteNames.addCourseScreen: (ctx) => const AddCourseScreen(),
      },
    );
  }
}
// 