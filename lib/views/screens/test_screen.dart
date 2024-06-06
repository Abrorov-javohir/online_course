import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/courses/add_test.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  bool isCorrect = false;

  void checkAnswer(int selectedIndex) {
    setState(() {
      isAnswered = true;
      isCorrect =
          tests[currentQuestionIndex].correctOptionIndex == selectedIndex;
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % tests.length;
      isAnswered = false;
      isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final test = tests[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              test.question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...List.generate(test.options.length, (index) {
              return ListTile(
                title: Text(test.options[index]),
                leading: Radio<int>(
                  value: index,
                  groupValue: isAnswered ? test.correctOptionIndex : null,
                  onChanged: isAnswered
                      ? null
                      : (value) {
                          if (value != null) checkAnswer(value);
                        },
                ),
              );
            }),
            SizedBox(height: 20),
            if (isAnswered)
              Text(
                isCorrect ? 'Correct!' : 'Incorrect!',
                style: TextStyle(
                  color: isCorrect ? Colors.green : Colors.red,
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text('Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}
