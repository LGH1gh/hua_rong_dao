import 'package:flutter/material.dart';
import 'package:hua_rong_dao/controller/controller.dart';
import 'package:hua_rong_dao/view/component/game_panel_tile.dart';

class GamePanel extends StatefulWidget {
  final Controller controller;
  GamePanel(this.controller);
  @override
  State<StatefulWidget> createState() => _GamePanel(controller);
}

class _GamePanel extends State<GamePanel> {
  Controller controller;
  List<Widget> components = new List();
  _GamePanel(this.controller);

  @override
  Widget build(BuildContext context) {
    controller.setWidth((MediaQuery.of(context).size.width - 80) / 4);
    components.add(new Container(
      height: controller.getWidth() * 5,
      width: controller.getWidth() * 4,
      color: Colors.red,
    ));
    if (controller.gameModel.game != null) {
      for (int i = 0; i < controller.gameModel.game.tiles.length; ++i) {
        components.add(new Tile(controller, controller.gameModel.game.tiles[i]));
      }
    }
    return new Stack(
      children: components,
    );
  }
}