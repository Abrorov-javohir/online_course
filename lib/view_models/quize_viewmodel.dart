
import 'package:flutter_application_1/models/quiz.dart';

class QuizesViewmodel {
  List<Test> _list = [];

  List<Test> get list {
    return [..._list];
  }
}
