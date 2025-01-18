import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../quiz_provider.dart';
import '../models/question.dart'; // Ensure this import is present

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final question = quizProvider.questions[quizProvider.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.description,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...question.options.map((option) => OptionWidget(option: option)).toList(),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final Option option;

  const OptionWidget({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final quizProvider = context.read<QuizProvider>();
        quizProvider.nextQuestion(option.isCorrect);

        // Check if it's the last question
        if (quizProvider.currentQuestionIndex >= quizProvider.questions.length - 1) {
          Navigator.pushNamed(context, '/result');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(option.description),
      ),
    );
  }
}
