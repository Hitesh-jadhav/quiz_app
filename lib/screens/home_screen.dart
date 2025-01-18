import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../quiz_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<QuizProvider>().fetchQuestions().then((_) {
              Navigator.pushNamed(context, '/quiz');
            });
          },
          child: const Text('Start Quiz'),
        ),
      ),
    );
  }
}
