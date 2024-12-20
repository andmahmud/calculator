import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Calculator",
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _input = '';
        _result = '';
      } else if (value == "=") {
        try {
          _result = _evaluateExpression(_input);
        } catch (e) {
          _result = "Error";
        }
      } else {
        _input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression.replaceAll('x', '*'));
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  Widget _buildDisplay() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.bottomRight,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _input,
              style: const TextStyle(fontSize: 32, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return CalculatorButton(
      text: text,
      onTap: () => _onButtonPressed(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Solve Your Math", style: TextStyle(fontSize: 25)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildDisplay(),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("+"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("-"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("*"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildButton("0"),
                _buildButton("C"),
                _buildButton("="),
                _buildButton("/"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CalculatorButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(50), // Circular border radius
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.3), // Shadow color
                blurRadius: 10, // Spread of the shadow
                offset: const Offset(2, 2), // Position of the shadow
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

