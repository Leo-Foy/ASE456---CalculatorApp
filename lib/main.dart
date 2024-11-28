import 'dart:math';

import 'package:calculator/button.dart';
import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userQuestion = '';
  String userAnswer = '';
  String lastAnswer = '0';
  String lastButtonPressed = '';
  late List<Button> buttons;

  @override
  void initState() {
    super.initState();
    buttons = [
      Button(label: 'C', onPressed: () => setState(() => clear())),
      Button(label: 'DEL', onPressed: () => setState(() => delete())),
      Button(label: '%', onPressed: () => addToUserQuestion('%')),
      Button(label: '/', onPressed: () => addToUserQuestion('/')),

      Button(label: '7', onPressed: () => addToUserQuestion('7')),
      Button(label: '8', onPressed: () => addToUserQuestion('8')),
      Button(label: '9', onPressed: () => addToUserQuestion('9')),
      Button(label: '*', onPressed: () => addToUserQuestion('*')),

      Button(label: '4', onPressed: () => addToUserQuestion('4')),
      Button(label: '5', onPressed: () => addToUserQuestion('5')),
      Button(label: '6', onPressed: () => addToUserQuestion('6')),
      Button(label: '-', onPressed: () => addToUserQuestion('-')),

      Button(label: '1', onPressed: () => addToUserQuestion('1')),
      Button(label: '2', onPressed: () => addToUserQuestion('2')),
      Button(label: '3', onPressed: () => addToUserQuestion('3')),
      Button(label: '+', onPressed: () => addToUserQuestion('+')),

      Button(label: '0', onPressed: () => addToUserQuestion('0')),
      Button(label: '.', onPressed: () => addToUserQuestion('.')),
      Button(label: 'ANS', onPressed: () => ans()),
      Button(label: '=', onPressed: () => equals()),

      Button(label: 'sinh', onPressed: () => sinhButton()),
    ];
  }

  void calculateExpression() {
    Parser p = Parser();
    Expression expression = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);

    setState(() {
      if (eval.isInfinite) {
        userAnswer = 'Cannot divide by zero';
      } else if (eval.toString().length > 16) {
        userAnswer = eval.toString().substring(0, 16);
        lastAnswer = userAnswer;
      } else {
        userAnswer = eval.toString();
        lastAnswer = userAnswer;
      }
    });
  }

  void clear() {
    userQuestion = '';
    userAnswer = '';
  }

  void delete() {
    if (userQuestion.isNotEmpty) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
    }
  }

  void ans() {
    if (userQuestion.length + lastAnswer.length < 16) {
      userQuestion += lastAnswer;
    }
  }

  void equals() {
    calculateExpression();
  }

  void addToUserQuestion(String input) {
    if (userQuestion.length < 16) {
      userQuestion += input;
    }
  }


  double sinh(double x) {
    return (exp(x) - exp(-x)) / 2;
  }

  void sinhButton() {
    try {
      double numberInput = double.parse(userQuestion);

      double result = sinh(numberInput);

      setState(() {
        userAnswer = result.toStringAsFixed(10); // Display up to 10 decimals
      });
    } catch (e) {
      setState(() {
        userAnswer = "Error"; // Error for invalid input
      });
    }
  }

  TextStyle displayStyle = TextStyle(
    color: Colors.deepPurple[900],
    fontWeight: FontWeight.bold,
    fontSize: 48,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          // Input and result display
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: displayStyle,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: displayStyle,
                  ),
                ),
              ],
            ),
          ),

          // Buttons
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                itemCount: buttons.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: buttons[index].label,
                    buttonColor: Colors.deepPurple[100],
                    textColor: Colors.black,
                    function: () {
                      setState(() {
                        buttons[index].onPressed();
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
