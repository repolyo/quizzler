import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final totalQuestions = 15;
  List<Icon> scoreKeeper = [];

  final Map<String, bool> data = {
    "You can lead a cow down stairs but not up stairs.": false,
    "Approximately one quarter of human bones are in the feet.": true,
    "A slug's blood is green.": true,
    "A crocodile cannot stick its tongue out": true,
    "A shrimp's heart is in its head": true,
    "Is it possible for pigs to look up into the sky": false,
    "If you sneeze too hard, you could fracture a rib": false,
    "Lipsticks contain fish scales": false,
    "Cat urine glows under a black-light": true,
    "The lyrebird can mimic almost any sounds it hears — including chainsaws.":
        true,
    "Like fingerprints, everyone's tongue print is different": true,
    "Rubber bands last longer when refrigerated": true,
    "The odds of getting a royal flush are exactly 1 in 649,740.": true,
    "There are 293 ways to make change for a dollar.": true,
    "A shark is the only known fish that can blink with both eyes.": true,
    "A cat has 32 muscles in each ear.": true,
    "You can hear a blue whale's heartbeat from more than 2 miles away.": false,
    "Ostrich's eye is smaller than its brain.": false,
    "A team of six women programmed the first digital computer.": true,
    "Tigers have striped skin, not just striped fur.": true,
    "The giant squid has the largest eyes in the world.": true,
    "Most people fall asleep in seven minutes.": true,
    "Apple Pie is American": false,
    "M&M stands for Mars and Murrie.": true,
    "Facebook has more users than many major populations.": true,
    "The unicorn is the national animal of Scotland.": true,
    "Is it possible for most people to lick their own elbow?": false,
    "\"Stewardesses\" is the longest word that is typed with only the left hand":
        true,
    "In the course of an average lifetime, while sleeping you might eat around 70 assorted insects and 10 spiders, or more.":
        true,
    "Wearing headphones for just an hour could increase the bacteria in your ear by 700 times.":
        true,
    "\"Dreamt\" is the only English word that ends in the letters \"mt\".":
        true,
    "The characters Bert and Ernie on Sesame Street were named after Bert the cop and Ernie the taxi driver in Frank Capra's \"It's a Wonderful Life.\"":
        true,
  };

  late final List questions;

  @override
  void initState() {
    scoreKeeper.clear();
    questions = data.keys.toList();

    super.initState();
  }

  validate(question, answer) {
    if (data[question] == answer) {
      return const Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return const Icon(
        Icons.close,
        color: Colors.red,
      );
    }
  }

  showAlertDialog(BuildContext context) {

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Finish!"),
      content: const Text(
          "You've reached the end of the quiz."),
      actions: [
        TextButton(
          child: const Text("Continue"),
          onPressed: () {
            Navigator.of(context).pop(); // dismiss dialog
            setState(() {
              scoreKeeper.clear();
            });
          },
        ),
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss dialog
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = Random().nextInt(data.length - 1);
    final question = questions[index];

    if (scoreKeeper.length > totalQuestions) {
      Future.delayed(Duration.zero, () {
        showAlertDialog(context);
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '$question',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper.add(validate(question, true));
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper.add(validate(question, false));
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
