import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hua_rong_dao/controller/controller.dart';

class StatisticsPanel extends StatefulWidget {
  final Controller controller;
  StatisticsPanel(this.controller);

  @override
  State<StatefulWidget> createState() => _StatisticsPanel(controller);
}

class _StatisticsPanel extends State<StatisticsPanel> {
  _StatisticsPanel(Controller controller) {
    this.controller = controller;
  }

  String _name = "";
  Controller controller;
  Timer _timer;
  int _time = 0;
  int _bestTime = -1;
  int _step = 0;
  int _bestStep = -1;

  void stepPlus(int num) {
    setState(() {
      _step += num;
    });
  }

  void restart() {
    setState(() {
      _step = 0;
      timeStop();
      timeStart();
    });
  }

  void timeStart() {
    if (_timer == null) {
      _timer = new Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _time++;
          });
        }
      });
    }
  }

  void timeStop() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _time = 0;
    });
    _timer = null;
  }

  void timePause() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
  }

  getStep() {
    return _step;
  }

  getTime() {
    return _time;
  }

  @override
  Widget build(BuildContext context) {
    if (controller.gameModel.game != null) {
      this._name = controller.gameModel.game.name;
      this._bestStep = controller.gameModel.game.bestStep;
      this._bestTime = controller.gameModel.game.bestTime;
    }
    controller.statisticsModel.registerStepPlus(this.stepPlus);
    controller.statisticsModel.registerAllRestart(this.restart);
    controller.statisticsModel.registerTimeStart(this.timeStart);
    controller.statisticsModel.registerTimeStop(this.timeStop);
    controller.statisticsModel.registerTimePause(this.timePause);
    controller.statisticsModel.registerGetStep(this.getStep);
    controller.statisticsModel.registerGetTime(this.getTime);
    timeStart();
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_name',
              style: new TextStyle(
                wordSpacing: 5.0, //单词间隙(负值可以让单词更紧凑)
                letterSpacing: 5.0, //字母间隙(负值可以让字母更紧凑)
                fontStyle: FontStyle.normal, //文字样式，斜体和正常
                fontSize: 30.0, //字体大小
                fontWeight: FontWeight.w900, //字体粗细  粗体和正常
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Best Step"),
                Text('$_bestStep'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Step"),
                Text("$_step"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Best Time"),
                Text('$_bestTime' + 's'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Timing"),
                Text('$_time' + 's'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
