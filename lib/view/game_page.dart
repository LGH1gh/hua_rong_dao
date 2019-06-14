import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hua_rong_dao/controller/controller.dart';
import 'package:hua_rong_dao/view/home_page.dart';
import 'package:hua_rong_dao/view/component/statistics_panel.dart';
import 'package:hua_rong_dao/view/component/game_panel.dart';
import 'package:hua_rong_dao/view/component/function_panel.dart';

class GamePage extends StatefulWidget {
  final Controller controller;
  GamePage(this.controller);

  @override
  State<StatefulWidget> createState() => _GamePage(controller);
}

class _GamePage extends State<GamePage> {
  final Controller controller;
  _GamePage(this.controller) {
    this.controller.gameModel.rebuildGame = build;
    this.controller.gameModel.showSuccess = showSuccess;
  }

  showSuccess() {
    String name = controller.gameModel.game.name;
    int step = controller.getStep();
    int time = controller.getTime();
    int bestStep = controller.gameModel.game.bestStep;
    int bestTime = controller.gameModel.game.bestTime;
    bool breakRegard = false;
    if (bestStep > step) {
      breakRegard = true;
    } else if (bestStep == step && bestTime > time) {
      breakRegard = true;
    }
    String conclusion = "";
    if (breakRegard) {
      conclusion = "恭喜你！你成功打破纪录。";
    } else {
      conclusion = "您未能打破纪录，请再接再厉！";
    }
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('恭喜！'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('你已经顺利通关：$name'),
                Text(conclusion),
                Text('所用步数：$step, 所用时间：$time')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new HomePage(controller);
                })
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: new Text('游戏'),
        ),
        body: new FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString(controller.getPath()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> game = json.decode(snapshot.data.toString());
              controller.start(game[controller.getIndex()]);
            }

            return new SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    StatisticsPanel(controller),
                    SizedBox(height: 15.0),
                    GamePanel(controller),
                    SizedBox(height: 10.0),
                    FunctionalPanel(controller),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
