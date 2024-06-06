
import 'package:flutter_application_1/models/quiz.dart';

class QuizesViewmodel {
  List<Quiz> _list = [];

  List<Quiz> get list {
    return [..._list];
  }
}
