import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Responsiva',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
      } else if (buttonText == '=' && _input.isNotEmpty) {
        try {
          _input = _evaluateExpression(_input).toString();
        } catch (e) {
          _input = 'Erro';
        }
      } else {
        _input += buttonText;
      }
    });
  }

  double _evaluateExpression(String expression) {
    // Aqui você pode implementar uma lógica de avaliação de expressões matemáticas
    // Uma forma simples seria utilizar o pacote "expressions" ou algum similar,
    // mas por agora vou deixar um código simples para simplificação.

    // A solução mais simples seria usar a função `eval` de alguma biblioteca, mas aqui é apenas ilustrativo.
    // Se você deseja uma solução real para avaliar expressões, considere usar pacotes de parser de expressões.
    try {
      // Calculando a expressão (Nota: Um método simples de avaliação)
      return double.parse(expression); // Esse é um exemplo simples para ilustrar
    } catch (e) {
      return 0.0; // Retorna zero em caso de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Responsiva'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Layout para telas pequenas (celular)
            return MobileLayout(onButtonPressed: _onButtonPressed, input: _input);
          } else {
            // Layout para telas grandes (desktop)
            return DesktopLayout(onButtonPressed: _onButtonPressed, input: _input);
          }
        },
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  final Function(String) onButtonPressed;
  final String input;

  MobileLayout({required this.onButtonPressed, required this.input});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            input,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildButton('7', onButtonPressed),
              _buildButton('8', onButtonPressed),
              _buildButton('9', onButtonPressed),
              _buildButton('/', onButtonPressed),
              _buildButton('4', onButtonPressed),
              _buildButton('5', onButtonPressed),
              _buildButton('6', onButtonPressed),
              _buildButton('*', onButtonPressed),
              _buildButton('1', onButtonPressed),
              _buildButton('2', onButtonPressed),
              _buildButton('3', onButtonPressed),
              _buildButton('-', onButtonPressed),
              _buildButton('0', onButtonPressed),
              _buildButton('.', onButtonPressed),
              _buildButton('C', onButtonPressed),
              _buildButton('+', onButtonPressed),
              _buildButton('=', onButtonPressed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final Function(String) onButtonPressed;
  final String input;

  DesktopLayout({required this.onButtonPressed, required this.input});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Caixa de exibição de entrada
          Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  input,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Grade de botões
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildButton('7', onButtonPressed),
                    _buildButton('8', onButtonPressed),
                    _buildButton('9', onButtonPressed),
                    _buildButton('/', onButtonPressed),
                    _buildButton('4', onButtonPressed),
                    _buildButton('5', onButtonPressed),
                    _buildButton('6', onButtonPressed),
                    _buildButton('*', onButtonPressed),
                    _buildButton('1', onButtonPressed),
                    _buildButton('2', onButtonPressed),
                    _buildButton('3', onButtonPressed),
                    _buildButton('-', onButtonPressed),
                    _buildButton('0', onButtonPressed),
                    _buildButton('.', onButtonPressed),
                    _buildButton('C', onButtonPressed),
                    _buildButton('+', onButtonPressed),
                    _buildButton('=', onButtonPressed),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      ),
    );
  }
}
