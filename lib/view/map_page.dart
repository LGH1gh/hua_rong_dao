import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:hua_rong_dao/controller/controller.dart';
import 'package:hua_rong_dao/view/game_page.dart';
import 'dart:convert';

class MapPage extends StatefulWidget {
  final Controller controller;
  MapPage(this.controller);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MapPage(this.controller);
  }
}

class _MapPage extends State<MapPage> {
  final Controller controller;
  _MapPage(this.controller);

  @override
  Widget build(BuildContext context) {
    String path;
    path = "lib/data/official_game_info.json";

    return Scaffold(
        appBar: AppBar(
          title: Text("地图"),
        ),
        body: new FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString(path),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> maps = json.decode(snapshot.data.toString());
              controller.setLength(maps.length);

              return new GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  padding: EdgeInsets.all(10.0),
                  itemCount: maps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: () {
                        if (controller.getMode() == "tutorial") {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) {
                            controller.setIndex(index);
                            return new GamePage(controller);
                          }));
                        }
                      },
                      child: Tile(
                          "${maps[index]["src"]}", "${maps[index]["name"]}"),
                    );
                  });
            } else {
              return new Container(width: 0.0, height: 0.0);
            }
          },
        ));
  }
}

class _Tile extends State<Tile> {
  final String image;
  final String name;
  Color favorite = Colors.grey;
  Color check = Colors.grey;
  _Tile(this.image, this.name);

  changeFavorite() {
    setState(() {
      if (favorite == Colors.grey) {
        favorite = Colors.red;
      } else {
        favorite = Colors.grey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Image.asset(image),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(10.0),
              child: Row( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.favorite, color: favorite,),
                  Text("喜欢")
                ],
              ),
              onPressed: () {
                changeFavorite();
              }),
            Icon(
              Icons.check,
              color: check,
            )
          ],
        ),
        new Text(
          name,
          style: new TextStyle(
            wordSpacing: 5.0, //单词间隙(负值可以让单词更紧凑)
            letterSpacing: 5.0, //字母间隙(负值可以让字母更紧凑)
            fontStyle: FontStyle.normal, //文字样式，斜体和正常
            fontSize: 15.0, //字体大小
            fontWeight: FontWeight.w900, //字体粗细  粗体和正常
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

}

class Tile extends StatefulWidget {
  final String image;
  final String name;
  Tile(this.image, this.name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Tile(this.image, this.name);
  }
}
