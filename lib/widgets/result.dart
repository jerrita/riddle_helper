import 'package:flutter/material.dart';
import 'package:riddle_helper/widgets/method.dart';

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required List<List<int>> this.sequence})
      : super(key: key);
  final sequence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            for (var step in sequence) ResultMethod(step: step),
          ],
        ),
      ),
    );
  }
}
