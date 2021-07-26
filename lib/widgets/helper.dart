import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle_helper/view_models/organ_view_model.dart';
import 'package:riddle_helper/widgets/organ.dart';
import 'package:riddle_helper/widgets/result.dart';

class RiddleHelper extends StatelessWidget {
  const RiddleHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _model = Provider.of<OrganViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riddle Helper'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('稻妻解密小助手'),
            for (var id = 1; id <= _model.nums; id++)
              OrganView(
                id: id,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                    onPressed: () {
                      _model.removeOrgan();
                    },
                    icon: Icon(Icons.remove),
                    label: Text('移除机关')),
                OutlinedButton.icon(
                    onPressed: () {
                      _model.removeAllStates();
                    },
                    icon: Icon(Icons.delete),
                    label: Text('清空')),
                OutlinedButton.icon(
                    onPressed: () {
                      _model.addOrgan();
                    },
                    icon: Icon(Icons.add),
                    label: Text('添加机关'))
              ],
            )
          ],
        ),
      ),
      // 计算
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var cancel = BotToast.showLoading();
          _model.calcResult().then((value) {
            cancel();
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => ResultView(
                          sequence: value,
                        )));
          });
        },
        child: Icon(Icons.calculate),
      ),
    );
  }
}
