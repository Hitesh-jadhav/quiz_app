import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final score = quizProvider.score;
    final totalQuestions = quizProvider.questions.length;
    final userAnswers = quizProvider.userAnswers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Correct Answers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...List.generate(totalQuestions, (index) {
              final question = quizProvider.questions[index];
              final userAnswer = userAnswers[index];
              final correctOption = question.options.firstWhere((option) => option.isCorrect);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q${index + 1}: ${question.description}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Correct Answer: ${correctOption.description}',
                    style: TextStyle(
                      fontSize: 16,
                      color: userAnswer ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<QuizProvider>().reset();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
