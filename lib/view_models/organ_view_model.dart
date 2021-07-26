import 'package:flutter/material.dart';
import 'package:riddle_helper/models/organ_model.dart';
import 'package:bot_toast/bot_toast.dart';

class OrganViewModel extends ChangeNotifier {
  final _model = OrganModel();
  final _organIcons = {
    0: Icons.done,
    1: Icons.chevron_left,
    2: Icons.expand_less,
    3: Icons.chevron_right
  };

  // 获取标签
  Set<int> getLabels(int id) => _model.labels[id] ?? {};
  // 获取图标
  Icon getStateIcon(int id) => Icon(_organIcons[_model.states[id] ?? 0]);
  get organIcons => _organIcons;
  // 获取机关状态
  int getState(int id) => _model.states[id] ?? 0;
  // 获取机关总数
  get nums => _model.nums;
  // 获取序列
  Future<List<List<int>>> calcResult() async => _model.calcResult();

  void addOrgan() {
    if (!_model.addOrgan()) {
      // 超过限制

    } else
      notifyListeners();
  }

  void removeOrgan() {
    _model.removeOrgan();
    notifyListeners();
  }

  // 增加一个标签
  void addLabel(int id, [int after = 1]) {
    if (!_model.addLabel(id, after)) {
      print('Label is full!');
    } else
      notifyListeners();
  }

  // 更改一个标签
  void changeLabel(int id, int lable) {
    if (_model.getAvaliableLabelAfter(id, lable) != 0) {
      _model.addLabel(id, lable);
      _model.deleteLabel(id, lable);
      notifyListeners();
    }
  }

  // 删除最后一个标签
  void removeLabel(int id) {
    if (getLabels(id).isEmpty)
      print('Label is null!');
    else {
      _model.removeLabel(id);
      notifyListeners();
    }
  }

  // 清空标签
  void removeAllStates() {
    _model.deleteAllStates();
    notifyListeners();
  }

  // 状态增 1
  void addState(int id) {
    _model.addState(id);
    notifyListeners();
  }
}
