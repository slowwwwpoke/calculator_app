import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _operand = '';
  int _firstOperand = 0;
  bool _shouldClear = false;

  void _onPressed(String value) {
    setState(() {
      if ('0123456789.'.contains(value)) {
        if (_shouldClear) {
          _display = '';
          _shouldClear = false;
        }
        _display += value;
      } else if ('+-*/'.contains(value)) {
        _firstOperand = int.parse(_display);
        _operand = value;
        _shouldClear = true;
      } else if (value == '=') {
        double secondOperand = double.parse(_display);
        switch (_operand) {
          case '+':
            _display = (_firstOperand + secondOperand).toString();
            break;
          case '-':
            _display = (_firstOperand - secondOperand).toString();
            break;
          case '*':
            _display = (_firstOperand * secondOperand).toString();
            break;
          case '/':
            _display = secondOperand == 0 ? 'Error' : (_firstOperand / secondOperand).toString();
            break;
        }
        _operand = '';
        _shouldClear = true;
      } else if (value == 'C') {
        _display = '0';
        _firstOperand = 0;
        _operand = '';
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 48, color: Colors.black),
            ),
          ),
          Row(children: [_buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('/')]),
          Row(children: [_buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('*')]),
          Row(children: [_buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-')]),
          Row(children: [_buildButton('0'), _buildButton('C'), _buildButton('+')]),
          Row(children: [_buildButton('=')]),
        ],
      ),
    );
  }
}
