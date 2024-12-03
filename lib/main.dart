import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'dart:math';
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
  String lastAnswer ='0';
  String lastButtonPressed = '';
  late List<Button> buttons;

  @override
  void initState() {
    super.initState();
    buttons = [
      Button(label:'C', onPressed: () => setState(() {clear(); lastButtonPressed='C';})),
      Button(label:'DEL', onPressed: () => setState(() {delete();})),
      Button(label:'%', onPressed: () => addToUserQuestion('%')),
      Button(label:'/', onPressed: () => addToUserQuestion('/')),
      Button(label: 'cosh', onPressed: () => setState(() { calculateCosh(); })), //cosh
      Button(label:'7', onPressed: () => addToUserQuestion('7')),
      Button(label:'8', onPressed: () => addToUserQuestion('8')),
      Button(label:'9', onPressed: () => addToUserQuestion('9')),
      Button(label:'*', onPressed: () => addToUserQuestion('*')),
      Button(label:'4', onPressed: () => addToUserQuestion('4')),
      Button(label:'5', onPressed: () => addToUserQuestion('5')),
      Button(label:'6', onPressed: () => addToUserQuestion('6')),
      Button(label:'-', onPressed: () => addToUserQuestion('-')),
      Button(label:'1', onPressed: () => addToUserQuestion('1')),
      Button(label:'2', onPressed: () => addToUserQuestion('2')),
      Button(label:'3', onPressed: () => addToUserQuestion('3')),
      Button(label:'+', onPressed: () => addToUserQuestion('+')),
      Button(label:'0', onPressed: () => addToUserQuestion('0')),
      Button(label:'.', onPressed: () => addToUserQuestion('.')),
      Button(label:'ANS', onPressed: () => ans()),
      Button(label:'=', onPressed: () => equals()),
      Button(label:'cos', onPressed: () => addToUserQuestion('cos')),
      Button(label:'(', onPressed: () => addToUserQuestion('(')),
      Button(label:')', onPressed: () => addToUserQuestion(')')),
      Button(label:'X^y', onPressed: () => addToUserQuestion('^')),
      Button(label:'Tan', onPressed: () => tanButton('Rad')),
      Button(label: 'sin', onPressed: () => addToUserQuestion('sin(')),
      Button(label: 'x²', onPressed: () => addToUserQuestion('^2')),
      Button(label: 'x³', onPressed: () => setState(() { cube(); })),
      Button(label:'log', onPressed: () => addToUserQuestion('log')),
      Button(label:'ln', onPressed: () => addToUserQuestion('ln')),
      Button(label: 'sinh', onPressed: () => sinhButton()),
    ];

  }

  void calculateExpression() {
    String expressionStr = userQuestion;

    expressionStr = expressionStr.replaceAllMapped(RegExp(r'sin\(([^)]+)\)'), (match) {
      double degrees = double.tryParse(match.group(1) ?? '0') ?? 0;
      return sin(degrees * (pi / 180)).toString();
    });

    expressionStr = expressionStr.replaceAllMapped(RegExp(r'(\d+)\^2'), (match) {
      double base = double.tryParse(match.group(1) ?? '0') ?? 0;
      return pow(base, 2).toString();
    });

    expressionStr = expressionStr.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (match) {
      double value = double.tryParse(match.group(1) ?? '0') ?? 0;
      return log(value).toString();
    });

    Parser p = Parser();
    try {
      Expression expression = p.parse(expressionStr);
      ContextModel cm = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, cm);

      setState(() {
        if (eval == null){
        userAnswer = 'Invalid Expression';
      } else if (eval.isInfinite) {
          userAnswer = 'Undefined';
        } else if (eval.isNaN) {
        userAnswer = 'Not a Number'; } else if (eval.toString().length > 7) {
          userAnswer = eval.toString().substring(0, 7);
          lastAnswer = userAnswer;
        } else {
          userAnswer = eval.toString();
          lastAnswer = userAnswer;
        }
      });
    } catch (e) {
      setState(() {
        userAnswer = "Error";
      });
    }
  }

  void cube() {
    try {
      // Parse the user input and calculate the cube
      double value = double.parse(userQuestion);
      double result = pow(value, 3).toDouble();

      setState(() {
        userAnswer = result.toString();
        lastAnswer = userAnswer;
        lastButtonPressed = 'x³';
      });
    } catch (e) {
      // Handle invalid input
      setState(() {
        userAnswer = 'Error';
      });
    }
  }

  void clear(){
    userQuestion ='';
    userAnswer = '';
  }

  void delete(){
    if (userQuestion.isNotEmpty) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      lastButtonPressed = 'DEL';
    }
  }

  void ans() {
    if (userQuestion.length + lastAnswer.length < 7) {
      if (lastButtonPressed == '=') {
        clear();
      }
      userQuestion += lastAnswer;
      lastButtonPressed = 'ANS';
    }
  }

  void equals(){
    lastButtonPressed = '=';
    calculateExpression();
  }

  void addToUserQuestion(String input){
    if (userQuestion.length < 7) {
      if (lastButtonPressed == '='){
        clear();
      }
      userQuestion += input;
      lastButtonPressed = input;
    }
  }

  void tanButton(String unit){
    //only calculates radians at the moment
    double numberInput= double.parse(userQuestion);
    double result = tan(numberInput);

    setState(() {
      if (result.toString().length > 7){
        userAnswer = result.toString().substring(0,7);
      }
      else {
        userAnswer = result.toString();
      }

    });
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

  //Cosh
  void calculateCosh() {
    try {
      double value = double.parse(userQuestion);
      double result = (exp(value) + exp(-value)) / 2.0; // Formula to calculate hyperbolic cosine
      setState(() {
        userAnswer = result.toString();
        lastAnswer = userAnswer;
        lastButtonPressed = 'cosh';
      });
    } catch (e) {
      // Handle any calculation errors
      setState(() {
        userAnswer = 'Error';
      });
    }
  }

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
        Flexible(
          child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11, // Number of buttons per row
              mainAxisSpacing: 8, // Spacing between rows
              crossAxisSpacing: 8, // Spacing between columns
              childAspectRatio: 1, // Maintain a square aspect ratio for buttons
            ),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 70,  // Fixed width for each button
                height: 70, // Fixed height for each button
                child: MyButton(
                  child: buttons[index].label,
                  buttonColor: Colors.deepPurple[100],
                  textColor: Colors.black,
                  function: () {
                    setState(() {
                      buttons[index].onPressed();
                    });
                  },
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
