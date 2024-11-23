import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

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
      Button(label:'C', onPressed: () => setState(() {clear(); lastButtonPressed='C';})), //0
      Button(label:'DEL', onPressed: () => setState(() {delete();})), //1
      Button(label:'%', onPressed: () => addToUserQuestion('%')), //2
      Button(label:'/', onPressed: () => addToUserQuestion('/')), //3
      Button(label:'7', onPressed: () => addToUserQuestion('7')), //4
      Button(label:'8', onPressed: () => addToUserQuestion('8')), //5
      Button(label:'9', onPressed: () => addToUserQuestion('9')), //6
      Button(label:'*', onPressed: () => addToUserQuestion('*')), //7
      Button(label:'4', onPressed: () => addToUserQuestion('4')), //8
      Button(label:'5', onPressed: () => addToUserQuestion('5')), //9
      Button(label:'6', onPressed: () => addToUserQuestion('6')), //10
      Button(label:'-', onPressed: () => addToUserQuestion('-')), //11
      Button(label:'1', onPressed: () => addToUserQuestion('1')), //12
      Button(label:'2', onPressed: () => addToUserQuestion('2')), //13
      Button(label:'3', onPressed: () => addToUserQuestion('3')), //14
      Button(label:'+', onPressed: () => addToUserQuestion('+')), //15
      Button(label:'0', onPressed: () => addToUserQuestion('0')), //16
      Button(label:'.', onPressed: () => addToUserQuestion('.')), //17
      Button(label:'ANS', onPressed: () => ans()), //18
      Button(label:'=', onPressed: () => equals()), //19
      Button(label:'cos', onPressed: () => addToUserQuestion('cos')), //20
      Button(label:'(', onPressed: () => addToUserQuestion('(')), //21
      Button(label:')', onPressed: () => addToUserQuestion(')')), //22
      Button(label:'Tan', onPressed: () => tanButton('Rad')), //23
      Button(label: 'x³', onPressed: () => setState(() { cube(); })), //24
    ];

  }

  void calculateExpression() {
    Parser p = Parser();
    Expression expression = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);

    setState(() {
      if (eval.toString().length > 16){
        userAnswer = eval.toString().substring(0,16);
      }
      else {
        userAnswer = eval.toString();
      }
      lastAnswer = userAnswer;

      if (eval.isInfinite) {
        userAnswer = 'Cannot divide by zero';
      } else {
        userAnswer = eval.toString();
      }

    });
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
    if (userQuestion.length + lastAnswer.length < 16) {
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
    if (userQuestion.length < 16) {
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
      if (result.toString().length > 16){
        userAnswer = result.toString().substring(0,16);
      }
      else {
        userAnswer = result.toString();
      }

    });
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

        // buttons
        Expanded(
          flex: 2,
          child: Container(
            child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth / 90).floor();
              return GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1),
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
                  }
              );
            }),
          ),
        ),
      ]),
    );
  }
}
