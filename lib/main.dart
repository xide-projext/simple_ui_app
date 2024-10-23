 import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleUI(),
    );
  }
}

class SimpleUI extends StatefulWidget {
  @override
  _SimpleUIState createState() => _SimpleUIState();
}

class _SimpleUIState extends State<SimpleUI> {
  final inputController = TextEditingController();
  String resultText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple UI Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: inputController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  resultText = inputController.text; // 입력된 텍스트를 resultText에 설정
                });
              },
              child: Text('Show Result'),
            ),
            SizedBox(height: 20),
            Text(resultText), 
          ],
        ),
      ),
    );
  }
}