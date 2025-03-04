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
  double _secondOperand = 0;
  double _firstOperand = 0;
  String _prevOperand = '';
  bool _decimal = false;

  void _onPressed(String value) {
    setState(() {
      // if user inputs a number or decimal value, appends to the value to be evaluated
      if ('0123456789.'.contains(value)) {
        if(value == '.'){
          if(!_decimal){
            _display += value;
            _decimal = true;
          }
        }
        else{
          _display += value;
        }
        // if user inputs a operation, sets the current display value to first operand
        // _operand takes the operation to be made and the display is cleared
      } else if ('+-*/'.contains(value)) {
        _firstOperand = double.parse(_display);
        _secondOperand = 0;
        _operand = value;
        _display = '';
        _decimal = false;
        // if user inputs =, takes the current value and checks the operand
        // if operand is empty, check to see previous operand
      } else if (value == '=' && _display != '') {
        _secondOperand = _secondOperand == 0 ? double.parse(_display) : _secondOperand;
        double secondOperand = _secondOperand;
        if(_operand == ''){
          _operand = _prevOperand;
          _prevOperand = '';
        }
        // switch conditions for the operations
        // checks if the result is a integer, if yes converts to int
        switch (_operand) {
          case '+':
            if((_firstOperand + secondOperand) % 1 != 0){
              _display = (_firstOperand + secondOperand).toString();
              _firstOperand = _firstOperand + secondOperand;
            }
            else{
              _display = (_firstOperand + secondOperand).toInt().toString();
              _firstOperand = _firstOperand + secondOperand;
            }
            break;
          case '-':
            if((_firstOperand - secondOperand) % 1 != 0){
              _display = (_firstOperand - secondOperand).toString();
              _firstOperand = _firstOperand - secondOperand;
            }
            else{
              _display = (_firstOperand - secondOperand).toInt().toString();
              _firstOperand = _firstOperand - secondOperand;
            }
            break;
          case '*':
           if((_firstOperand - secondOperand) % 1 != 0){
              _display = (_firstOperand * secondOperand).toString();
              _firstOperand = _firstOperand * secondOperand;
            }
            else{
              _display = (_firstOperand * secondOperand).toInt().toString();
              _firstOperand = _firstOperand * secondOperand;
            }

            break;
          case '/':
            if(secondOperand != 0 && ((_firstOperand / secondOperand) % 1 != 0)){            
            _display = secondOperand == 0 ? 'Error' : (_firstOperand / secondOperand).toString();
            _firstOperand = _firstOperand / secondOperand;
            }
            else{
            _display = secondOperand == 0 ? 'Error' : (_firstOperand / secondOperand).toInt().toString();
            _firstOperand = _firstOperand / secondOperand;
            }
            break;
        }
        _prevOperand = _operand;
        _operand = '';
        _decimal = false;
      // if user inputs 'C', clears and resets to beginning values
      } else if (value == 'C') {
        _display = '';
        _firstOperand = 0;
        _prevOperand = '';
        _operand = '';
        _decimal = true;
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
            backgroundColor: Colors.blueGrey[800],
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
          Row(children: [_buildButton('0'), _buildButton('.'), _buildButton('C'), _buildButton('+')]),
          Row(children: [_buildButton('=')]),
        ],
      ),
    );
  }
}
