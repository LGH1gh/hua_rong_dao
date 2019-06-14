import 'package:flutter/material.dart';
import 'package:hua_rong_dao/model/game_info.dart';
import 'package:hua_rong_dao/controller/controller.dart';


class Tile extends StatefulWidget {
  final TileInfo info;
  final Controller controller;
  Tile(this.controller, this.info);

  @override
  State<StatefulWidget> createState() => _Tile(this.controller, this.info);
}

class _Tile extends State<Tile> {
  TileInfo info;
  Controller controller;

  double marginLeft;
  double marginTop;
  double blockHeight;
  double blockWidth;

  _Tile(Controller controller, TileInfo info) {
    this.controller = controller;
    this.info = info;

    blockWidth = controller.getWidth() * BLOCK_SHAPES[info.block.type][0];
    blockHeight = controller.getWidth() * BLOCK_SHAPES[info.block.type][1];
    marginLeft = controller.getWidth() * info.position[1];
    marginTop = controller.getWidth() * info.position[0];
    controller.gameModel.tileModel.registerSetPosition(info.tileId, setPosition);
    controller.gameModel.tileModel.registerUpdatePosition(info.tileId, updatePosition);
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      height: blockHeight,
      width: blockWidth,
      left: marginLeft,
      top: marginTop,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails details) {
          controller.moveStart(info.tileId);
        },
        onVerticalDragStart: (DragStartDetails details) {
          controller.moveStart(info.tileId);
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          controller.horizontalUpdate(info.tileId, details.delta.dx, marginLeft);
        },
        onVerticalDragUpdate: (DragUpdateDetails details) {
          controller.verticalUpdate(info.tileId, details.delta.dy, marginTop);
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          controller.moveStop(info.tileId, marginLeft, marginTop);
        },
        onVerticalDragEnd: (DragEndDetails details) {
          controller.moveStop(info.tileId, marginLeft, marginTop);
        },
        child: Card(
          color: Colors.amber,
          child: new Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Text(
                  info.block.name,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  updatePosition(double dx, double dy) {
    setState(() {
      marginLeft += dx;
      marginTop += dy;
    });
  }

  setPosition(List<int> position) {
    setState(() {
      info.position[1] = position[1];
      info.position[0] = position[0];
      marginLeft = controller.getWidth() * info.position[1];
      marginTop = controller.getWidth() * info.position[0];
    });
  }
}