import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/question.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<bool> _userAnswers = [];

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  List<bool> get userAnswers => _userAnswers;

  Future<void> fetchQuestions() async {
    final response = await http.get(Uri.parse('https://api.jsonserve.com/Uw5CrX'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _questions = (data['questions'] as List).map((item) => Question.fromJson(item)).toList();
      _userAnswers = List<bool>.filled(_questions.length, false);
      notifyListeners();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void nextQuestion(bool isCorrect) {
    _userAnswers[_currentQuestionIndex] = isCorrect;
    if (isCorrect) {
      _score++;
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    }
    notifyListeners();
  }

  void reset() {
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers = List<bool>.filled(_questions.length, false);
    notifyListeners();
  }
}

