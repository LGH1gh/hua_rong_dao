import 'package:flutter/material.dart';
import 'package:hua_rong_dao/controller/controller.dart';

class FunctionalPanel extends StatelessWidget {
  final Controller controller;
  FunctionalPanel(this.controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          child: Text("restart"),
          onPressed: controller.restart,
        ),
        RaisedButton(
          child: Text("withdraw"),
          onPressed: controller.withdraw,
        )
      ],
    );
  }
}