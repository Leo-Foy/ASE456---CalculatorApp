import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:calculator/main.dart';
import 'package:math_expressions/math_expressions.dart';

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

  final List buttons = [
    'C', // buttons[0]
    'DEL', // buttons[1]
    '%', // buttons[2]
    '/', // buttons[3]
    '9', // buttons[4]
    '8', // buttons[5]
    '7', // buttons[6]
    '*', // buttons[7]
    '6', // buttons[8]
    '5', // buttons[9]
    '4', // buttons[10]
    '-', // buttons[11]
    '3', // buttons[12]
    '2', // buttons[13]
    '1', // buttons[14]
    '+', // buttons[15]
    '0', // buttons[16]
    '.', // buttons[17]
    'ANS', // buttons[18]
    '=', // buttons[19]
  ];

  void calculateExpression() {
    Parser p = Parser();
    Expression expression = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);

    setState(() {
      userAnswer = eval.toString();
    });
  }

  void pressedButton(String button) {
    if (button == 'C') {
      setState(() {
        userQuestion = '';
        userAnswer = '';
      });
    } else if (button == 'DEL') {
      setState(() {
        userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      });
    } else if (button == '=') {
      calculateExpression();
    } else {
      setState(() {
        userQuestion += button;
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
      body: Column(children: [
        // Q and A
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 75),
            height: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        userQuestion,
                        style: displayStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        userAnswer,
                        style: displayStyle,
                      ),
                    ],
                  )
                ]),
          ),
        ),

        // buttons
        Expanded(
          flex: 2,
          child: Container(
              height: 200,
              child: GridView.builder(
                  itemCount: buttons.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return MyButton(
                      child: buttons[index],
                      buttonColor: Colors.deepPurple[100],
                      textColor: Colors.black,
                      function: () {
                        pressedButton(buttons[index]);
                      },
                    );
                  })),
        ),
      ]),
    );
  }
}
