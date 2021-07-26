import 'package:flutter/material.dart';

class ResultMethod extends StatelessWidget {
  const ResultMethod({Key? key, required List<int> this.step})
      : super(key: key);
  final step;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(step.toString()),
    );
  }
}
