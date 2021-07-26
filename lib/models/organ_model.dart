import 'dart:collection';

import 'package:bot_toast/bot_toast.dart';
import 'package:riddle_helper/utils/ranger.dart';

class OrganModel {
  // 记录机关具有的标签
  Map<int, Set<int>> _labels = {};

  // 记录机关当前的状态
  Map<int, int> _states = {};

  // 当前机关总数
  int _nums = 3;

  get labels => _labels;
  get states => _states;
  get nums => _nums;

  bool addOrgan() {
    if (_nums == 8) {
      BotToast.showText(text: '机关数过多，请充值解锁！');
      return false;
    } else
      _nums++;
    return true;
  }

  void removeOrgan() {
    _states.removeWhere((key, value) => key == _nums);
    _labels[_nums]?.clear();
    _nums--;
  }

  int getAvaliableLabelAfter(int id, int after) {
    _labels[id] = _labels[id] ?? {};
    var l = range(after, _nums);
    l.addAll(range(1, after));
    for (var i in l) {
      if (i == id || _labels[id]!.contains(i))
        continue;
      else
        return i;
    }
    return 0;
  }

  void addState(int id) {
    var now = _states[id] ?? 0;
    _states[id] = (now + 1) % 4;
  }

  bool addLabel(int id, [int after = 1]) {
    var res = getAvaliableLabelAfter(id, after);
    if (res != 0) {
      _labels[id]!.add(res);
      return true;
    } else
      return false;
  }

  void deleteLabel(int id, int label) {
    _labels[id]!.remove(label);
  }

  // 清空所有数据
  void deleteAllStates() {
    _labels = {};
    _states = {};
    _nums = 3;
  }

  // 移除最后一个标签
  void removeLabel(int id) {
    _labels[id]!.remove(_labels[id]!.last);
  }

  // 计算合法序列
  List<List<int>> res = [];
  List<List<int>> calcResult() {
    res.clear();
    // 当前机关数：_nums
    // 机关状态：_states[id]
    // 机关标签：_labels[id]
    dfs(0);
    return res;
  }

  Queue<int> _seq = Queue();
  void dfs(int depth) {
    if (depth != _nums) {
      for (var i = 0; i < 4; i++) {
        _seq.addLast(i);
        dfs(depth + 1);
        _seq.removeLast();
      }
    } else {
      // 到头了
      var tSeq = _seq.toList();
      var tStates = new Map<int, int>.from(_states);

      for (var i = 1; i <= tSeq.length; i++) {
        // 对于标签内的每个机关，应用一次结果
        _labels[i]?.forEach((element) {
          tStates[element] = ((tStates[element] ?? 0) + tSeq[i - 1]) % 4;
        });
        tStates[i] = ((tStates[i] ?? 0) + tSeq[i - 1]) % 4;
      }

      bool flag = true;
      tStates.forEach((key, value) {
        if (value != 0) flag = false;
      });

      if (flag) {
        print('Find: $tSeq');
        res.add(tSeq);
      }
    }
  }
}
