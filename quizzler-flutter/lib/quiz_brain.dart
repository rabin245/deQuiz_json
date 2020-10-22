import 'dart:convert';

import 'package:flutter/services.dart';

import 'models/question_model.dart';

Future<List<QuestionModel>> getQuestions() async {
  // We're reading from file [asset] here. Which is I/O operations and takes some time to complete.
  // So we're using calling everything asynchronously. And awaiting the read from file to complete.
  final questionsJson = await rootBundle.loadString('assets/json/questions.json');

  // Since 'questionsJson` is a string, we can't perform much operations on it.
  // So, we're converting it to Dart's object.
  //
  // i.e. we're converting JSONArray into Dart's List.
  final List<dynamic> rawQuestions = jsonDecode(questionsJson);

  // Here we're converting List<dynamic> into List<QuestionModel>
  // Reason: dynamic is not a strong time so we can't perform much operations on it.
  // So, we're modeling the data into our own data type [Model], which is [QuestionModel].
  return rawQuestions.map((questionMap) => QuestionModel.fromMap(questionMap)).toList();
}

/*
class QuizBrain {
  int _questionNumber = 0;
  int _userScore = 0;

  List<Question> _questionBank = [
    Question('Which is the tallest mountain in the world?', 'Mt.Everest', 'K2',
        'Annapurna', 'Dhaulagiri', 'Mt.Everest'),
    Question('Who was the first man to fly around the earth with a spaceship?',
        'Armstrong', 'Gagarin', 'Prachanda', 'Trump', 'Gagarin'),
    Question('In which country were the first Olympic Games held?', 'Rome',
        'Italy', 'Greece', 'Britian', 'Greece'),
    Question('What do the Japanese people call their own country?', 'Eikoku',
        'Beikoku', 'Nippon', 'Kankoku', 'Nippon'),
    Question('What island, which belonged to Denmark, was independent in 1944?',
        'Greece', 'Vinland', 'Iceland', 'Switzerland', 'Iceland'),
    Question('Which Turkish city has the name of a cartoon character?',
        'Superman', 'Batman', 'Spiderman', 'Micki Mouse', 'Batman'),
    Question('Who killed the Minotaur ?', 'Theseus', 'Perseus', 'Hercules',
        'Prometheus', 'Theseus'),
    Question('What is the name of the winged horse in Greek mythology?',
        'Unicorn', 'Pegasus', 'Minotaur', 'Griffin', 'Pegasus'),
    Question('What is the national sport in Japan?', 'Football',
        'Sumo Wrestling', 'Swimming', 'Sword Play', 'Sumo Wrestling'),
    Question(
      'Which football club has the most UCL wins?',
      'Barcelona',
      'Liverpool',
      'Real Madrid',
      'AC Milan',
      'Real Madrid',
    ),
    Question(
        'Which football club won three straight UEFA Champions League titles since the tournament\'s inception?',
        'AC Milan',
        'Bayern Munich',
        'Real Madrid',
        'Liverpool',
        'Real Madrid'),
    Question('When did dinosaurs become extinct?', '100M yrs ago',
        '65M yrs ago', '20M yrs ago', '200M yrs ago', '65M yrs ago'),
    Question(
        'During which era did dinosaurs dominate the world?',
        'Platezioc era',
        'Mesozoic era',
        'Cenozoic era',
        'Paleozoic era',
        'Mesozoic era'),
    Question(
        'Which is the largest land carnivorous animal?',
        'Tyrannosaurus Rex',
        'Spinosaurus',
        'Argentinosaurus',
        'Titanoceratops',
        'Spinosaurus'),
    Question('What is the largest predator in the world?', 'Brown Bear',
        'African Lion', 'Polar Bear', 'Siberean Tiger', 'Polar Bear'),
    Question(
        'Which actor appeared in famous films, such as \'Gone in 60 Seconds\'\', \'Face/Off\', \'Ghost Rider\'?',
        'Nicolas Cage',
        'Jhonny Depp',
        'Jeremy Renner',
        'Will Smith',
        'Nicolas Cage'),
    Question('In what year was Google launched on the web?', '1990', '1995',
        '2000', '1998', '1998'),
    Question('Which vitamin is the only one that you will not find in an egg?',
        'Vitamin A', 'Vitamin K', 'Vitamin C', 'Vitamin D', 'Vitamin C'),
    Question('Which vitamin is the only one that you will not find in an egg?',
        'Vitamin A', 'Vitamin K', 'Vitamin C', 'Vitamin D', null),
  ];

  void changeQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  String getOption1() {
    return _questionBank[_questionNumber].option1;
  }

  String getOption2() {
    return _questionBank[_questionNumber].option2;
  }

  String getOption3() {
    return _questionBank[_questionNumber].option3;
  }

  String getOption4() {
    return _questionBank[_questionNumber].option4;
  }

  String getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    _userScore = 0;
  }

  void increaseScore() {
    _userScore++;
  }

  int returnScore() {
    return _userScore;
  }
}*/
