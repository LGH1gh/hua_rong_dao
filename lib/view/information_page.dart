import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("地图"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 50.0),
            buildInformation1(),
            SizedBox(height: 5.0),
            buildInformation2(),
            SizedBox(height: 40.0),
            buildGameInformation1(),
            SizedBox(height: 20.0),
            buildGameInformation2(),
          ],
        ));
  }

  Row buildInformation1() {
    return Row(
      children: <Widget>[
        Text(
          '中文名称  :    华容道    ',
          style: TextStyle(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted
          ),
        ),
        SizedBox(width: 20.0),
        Text(
          '地区    :    中国    ',
          style: TextStyle(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted
          ),
        ),
      ],
    );
  }

  Row buildInformation2() {
    return Row(
      children: <Widget>[
        Text(
          '分类          :    益智玩具',
          style: TextStyle(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted
          ),
        ),
        SizedBox(width: 20.0),
        Text(
          '特点    :    变化多端、百玩不厌',
          style: TextStyle(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted
          ),
        ),
      ],
    );
  }

  Text buildGameInformation2() {
    return Text(
      '    通过移动各个棋子，帮助曹操从初始位置移到棋盘最下方中部，从出口逃走。不允许跨越棋子，还要设法用最少的步数把曹操移到出口。曹操逃出华容道的最大障碍是关羽，关羽立马华容道，一夫当关，万夫莫开。关羽与曹操当然是解开这一游戏的关键。四个刘备军兵是最灵活的，也最容易对付，如何发挥他们的作用也要充分考虑周全。“华容道”有一个带二十个小方格的棋盘，代表华容道。',
      overflow: TextOverflow.clip,
      style: TextStyle(
          color: Colors.black54,
          fontSize: 14,
          letterSpacing: 1,
          wordSpacing: 2,
          height: 1.2,
          fontWeight: FontWeight.w600
      ),
    );
  }

  Text buildGameInformation1() {
    return Text(
      '    华容道是古老的中国民间益智游戏，以其变化多端、百玩不厌的特点与魔方、独立钻石棋一起被国外智力专家并称为“智力游戏界的三个不可思议”。它与七巧板、九连环等中国传统益智玩具还有个代名词叫作“中国的难题”。据《资治通鉴》注释中说“从此道可至华容也”。华容道原是中国古代的一个地名，相传当年曹操曾经败走此地。由于当时的华容道是一片沼泽，所以曹操大军要割草填地，不少士兵更惨被活埋，惨烈非常。',
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14,
        letterSpacing: 1,
        wordSpacing: 2,
        height: 1.2,
        fontWeight: FontWeight.w600
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '华容道',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
