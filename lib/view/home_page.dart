import 'package:flutter/material.dart';
import 'package:hua_rong_dao/view/map_page.dart';
import 'package:hua_rong_dao/controller/controller.dart';
import 'package:hua_rong_dao/view/information_page.dart';

class HomePage extends StatelessWidget {
  final Controller controller;
  HomePage(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('主页')),
      backgroundColor: Colors.white,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("lib/data/image/logo.png"),
            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 20.0)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Tutorial"),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                    controller.setMode("tutorial");
                    return new MapPage(controller);
                  }));
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Information"),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) {
                        return new InformationPage();
                      }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
