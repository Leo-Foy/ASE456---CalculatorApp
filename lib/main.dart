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
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(children: [
        // Q and A
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 75),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        userQuestion,
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        userAnswer,
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  )
                ]),
            height: 200,
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
                      child: buttons[index].label,
                      buttonColor: Colors.deepPurple[100],
                      textColor: Colors.black,
                      function: () {
                        setState(() {
                          buttons[index].onPressed();
                        });
                      },
                    );
                  })),
        ),
      ]),
    );
  }
}
