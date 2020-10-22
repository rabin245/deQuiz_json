import 'package:deQUIZ/quiz_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audio_cache.dart';

import 'models/question_model.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          //Color(0xffF65150),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/1.png'),
            //maxRadius: 1,
            child: null,
          ),
          title: Text('deQuiz',
              style: TextStyle(
                color: Color(0xffF65150),
              )),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        //Colors.grey.shade900,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<QuestionModel> questionModels = [];
  List<Widget> scoreKeeper = [];
  int questionNumber = 0;
  int score = 0;

  final player = AudioCache();

  @override
  void initState() {
    super.initState();

    // Initializes the questions asynchronously
    _initQuestions();
  }

  @override
  void dispose() {
    questionModels.clear();
    scoreKeeper.clear();
    super.dispose();
  }

  Future<void> _initQuestions() async {
    questionModels = await getQuestions();

    // Updates the UI once initialization completes
    setState(() {});
  }

  void reset() {
    scoreKeeper.clear();
    questionNumber = 0;
    score = 0;
  }

  Future<void> checkOption(String option) async {
    if (option == questionModels[questionNumber].answer) {
      player.play('2.wav');
      scoreKeeper.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
      score++;
    } else {
      final player = AudioCache();
      player.play('3.wav');
      scoreKeeper.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
    questionNumber++;
    if (questionModels.length == questionNumber) {
      await Alert(
        context: context,
        title: 'Finished!',
        desc: 'You scored $score/${questionModels.length}!',
      ).show();
      reset();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (questionModels.isEmpty) {
      return Container();
    }

    final questionModel = questionModels[questionNumber];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionModel.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 1,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: questionModel.options.length,
            itemBuilder: (context, index) {
              final option = questionModel.options[index];
              return FlatButton(
                color: Colors.indigo.shade600,
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {
                  checkOption(option);
                },
                child: Text(
                  option,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: scoreKeeper,
        )
      ],
    );
  }
}
