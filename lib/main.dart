import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
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
  int currentQuestion = 0;
  List<Widget> scoreKeeper = [];

  Widget correctAnswer() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Widget wrongAnswer() {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  void nextQuestion() {
    if (currentQuestion < questionBank.length - 1) {
      currentQuestion++;
    } else {}
  }

  void gameOver() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "GAME OVER",
      desc: "Good job out there. Want to play again?",
      buttons: [
        DialogButton(
            child: Text(
              "Play Again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            width: 120,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestion = 0;
                scoreKeeper = [];
              });
            })
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[currentQuestion].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (currentQuestion < questionBank.length - 1) {
                  bool answer = questionBank[currentQuestion].questionAnswer;
                  if (answer == true) {
                    setState(() {
                      scoreKeeper.add(correctAnswer());
                      nextQuestion();
                    });
                  } else {
                    setState(() {
                      scoreKeeper.add(wrongAnswer());
                      nextQuestion();
                    });
                  }
                } else {
                  setState(() {
                    gameOver();
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (currentQuestion < questionBank.length - 1) {
                  bool answer = questionBank[currentQuestion].questionAnswer;
                  if (answer == false) {
                    setState(() {
                      scoreKeeper.add(correctAnswer());
                      nextQuestion();
                    });
                  } else {
                    setState(() {
                      scoreKeeper.add(wrongAnswer());
                      nextQuestion();
                    });
                  }
                } else {
                  setState(() {
                    gameOver();
                  });
                }
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
