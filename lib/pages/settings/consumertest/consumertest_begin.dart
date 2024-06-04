import 'package:flutter/material.dart';
import 'package:hello_worl2/model/models.dart';
import 'package:hello_worl2/provider/consumertestProvider.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  final Quiz quiz;

  StartPage({required this.quiz});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/image/stonks.jpg'),
        const Padding(padding: EdgeInsets.all(20)),
        Text(quiz.title, style: Theme.of(context).textTheme.headlineMedium),
        const Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Divider(),
        ),
        Expanded(child: Text(quiz.description)),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: state.nextPage,
            child: Text(
              'Starte Verbrauchertest!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        )
      ],
    );
  }
}
