import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle_helper/view_models/organ_view_model.dart';

class OrganView extends StatefulWidget {
  const OrganView({Key? key, required int this.id}) : super(key: key);
  final id;

  @override
  _OrganViewState createState() => _OrganViewState();
}

class _OrganViewState extends State<OrganView> {
  @override
  Widget build(BuildContext context) {
    var _model = Provider.of<OrganViewModel>(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                _model.addState(widget.id);
              },
              icon: _model.getStateIcon(widget.id)),
          Text('id: ${widget.id}'),
          // Labels
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 30,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              for (var label in _model.getLabels(widget.id))
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          // 更改标签
                          _model.changeLabel(widget.id, label);
                        },
                        child: Text(label.toString()))
                  ],
                ),
            ]),
          ),

          Spacer(),
          IconButton(
              onPressed: () {
                _model.removeLabel(widget.id);
              },
              icon: Icon(Icons.remove)),
          IconButton(
              onPressed: () {
                _model.addLabel(widget.id);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
