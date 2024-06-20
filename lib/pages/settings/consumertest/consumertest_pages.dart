import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_worl2/model/models.dart';
import 'package:hello_worl2/pages/settings/consumertest/consumertest_begin.dart';
import 'package:hello_worl2/pages/settings/consumertest/quiz.dart';
import 'package:hello_worl2/provider/consumertestProvider.dart';
import 'package:hello_worl2/widgets/animation_bar.dart';
import 'package:hello_worl2/widgets/error.dart';
import 'package:hello_worl2/widgets/loading.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;

  QuizScreen({required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizState>(
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            title: AnimatedProgressbar(value: state.progress),
            leading: IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: FutureBuilder<Quiz>(
            future: fetchQuiz(quizId),
            builder: (BuildContext context, AsyncSnapshot<Quiz> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              } else if (snap.hasError || !snap.hasData) {
                return ErrorScreen(error: "error");
              } else {
                Quiz quiz = snap.data!;
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: state.controller,
                  onPageChanged: (int idx) {
                    state.progress = (idx / (quiz.questions.length + 1));
                  },
                  itemBuilder: (BuildContext context, int idx) {
                    if (idx == 0) {
                      return StartPage(quiz: quiz);
                    } else if (idx == quiz.questions.length + 1) {
                      return CongratsPage(quiz: quiz);
                    } else {
                      return QuestionPage(question: quiz.questions[idx - 1]);
                    }
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<Quiz> fetchQuiz(String quizId) async {
    // Simulating network fetch using a delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Sample quiz data
    Map<String, dynamic> quizData = {
      'id': quizId,
      'title': 'Sample Quiz',
      'description': 'This is a sample quiz description.',
      'questions': [
        {
          'text': 'Sample Question 1',
          'options': [
            {'value': 'Option 1', 'correct': true, 'detail': 'Correct answer'},
            {
              'value': 'Option 2',
              'correct': false,
              'detail': 'Incorrect answer'
            },
          ],
        },
        {
          'text': 'Sample Question 2',
          'options': [
            {
              'value': 'Option A',
              'correct': false,
              'detail': 'Incorrect answer'
            },
            {'value': 'Option B', 'correct': true, 'detail': 'Correct answer'},
          ],
        },
      ],
      'topic': 'Sample Topic',
    };

    // Convert data to Quiz object
    return Quiz.fromJson(quizData);
  }
}
