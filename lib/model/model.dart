import 'package:hua_rong_dao/model/game_info.dart';

class GameModel {
  TileModel tileModel = new TileModel();
  String mode;
  int length;
  Map<String, String> director = new Map();
  int index;
  dynamic originJson;
  GameInfo game;
  List<Step> steps = new List();
  List<List<bool>> buffer = new List();
  double width;
  bool success = false;
  Function rebuildGame;
  Function showSuccess;

  GameModel() {
    director["tutorial"] = "lib/data/official_game_info.json";
    director["doubleGamer"] = "lib/data/official_game_info.json";
  }
  moveStart(int tileId) {
    int location = getLocation(tileId);
    int top = game.tiles[location].position[0];
    int left = game.tiles[location].position[1];
    switch (game.tiles[location].block.type) {
      case BlockType.LittleSquare:
        buffer[top][left] = false;
        break;
      case BlockType.LargeSquare:
        buffer[top][left] = false;
        buffer[top + 1][left] = false;
        buffer[top + 1][left + 1] = false;
        buffer[top][left + 1] = false;
        break;
      case BlockType.Rectangle:
        buffer[top][left] = false;
        buffer[top][left + 1] = false;
        break;
      case BlockType.TransRectangle:
        buffer[top][left] = false;
        buffer[top + 1][left] = false;
        break;
    }
  }
  horizontalUpdate(int tileId, double dx, double marginLeft) {
    int horizontalPos = ((marginLeft + dx) / width).floor();
    int location = getLocation(tileId);
    bool canMove = true;
    int vertical = game.tiles[location].position[0];
    switch (game.tiles[location].block.type) {
      case BlockType.LittleSquare:
        {
          if (buffer[vertical][horizontalPos] ||
              buffer[vertical][horizontalPos + 1]) {
            canMove = false;
          }
          break;
        }
      case BlockType.LargeSquare:
        {
          if (buffer[vertical][horizontalPos] ||
              buffer[vertical][horizontalPos + 2] ||
              buffer[vertical + 1][horizontalPos] ||
              buffer[vertical + 1][horizontalPos + 2]) {
            canMove = false;
          }
          break;
        }
      case BlockType.TransRectangle:
        {
          if (buffer[vertical][horizontalPos] ||
              buffer[vertical][horizontalPos + 1] ||
              buffer[vertical + 1][horizontalPos] ||
              buffer[vertical + 1][horizontalPos + 1]) {
            canMove = false;
          }
          break;
        }
      case BlockType.Rectangle:
        {
          if (buffer[vertical][horizontalPos] ||
              buffer[vertical][horizontalPos + 2]) {
            canMove = false;
          }
          break;
        }
    }
    if (canMove) {
      tileModel.updatePosition[tileId](dx, 0.0);
    }
  }
  verticalUpdate(int tileId, double dy, double marginTop) {
    int verticalPos = ((marginTop + dy) / width).floor();
    int location = getLocation(tileId);
    bool canMove = true;
    int horizontal = game.tiles[location].position[1];
    switch (game.tiles[location].block.type) {
      case BlockType.LittleSquare:
        {
          if (buffer[verticalPos][horizontal] ||
              buffer[verticalPos + 1][horizontal]) {
            canMove = false;
          }
          break;
        }
      case BlockType.LargeSquare:
        {
          if (buffer[verticalPos][horizontal] ||
              buffer[verticalPos + 2][horizontal] ||
              buffer[verticalPos][horizontal + 1] ||
              buffer[verticalPos + 2][horizontal + 1]) {
            canMove = false;
          }
          break;
        }
      case BlockType.TransRectangle:
        {
          if (buffer[verticalPos][horizontal] ||
              buffer[verticalPos + 2][horizontal]) {
            canMove = false;
          }
          break;
        }
      case BlockType.Rectangle:
        {
          if (buffer[verticalPos][horizontal] ||
              buffer[verticalPos][horizontal + 1] ||
              buffer[verticalPos + 1][horizontal] ||
              buffer[verticalPos + 1][horizontal + 1]) {
            canMove = false;
          }
          break;
        }
    }
    if (canMove) {
      tileModel.updatePosition[tileId](0.0, dy);
    }
  }
  moveStop(int tileId, double marginLeft, double marginTop) {
    int location = getLocation(tileId);
    int originTop = game.tiles[location].position[0];
    int originLeft = game.tiles[location].position[1];
    int top = (marginTop / width).round();
    int left = (marginLeft / width).round();
    if (originLeft != left || originTop != top) {
      steps.add(new Step(tileId, [top - originTop, left - originLeft]));
    }
    tileModel.setPosition[tileId]([top, left]);

    switch (game.tiles[location].block.type) {
      case BlockType.LittleSquare:
        buffer[top][left] = true;
        break;
      case BlockType.LargeSquare:
        buffer[top][left] = true;
        buffer[top][left + 1] = true;
        buffer[top + 1][left] = true;
        buffer[top + 1][left + 1] = true;
        break;
      case BlockType.TransRectangle:
        buffer[top][left] = true;
        buffer[top + 1][left] = true;
        break;
      case BlockType.Rectangle:
        buffer[top][left] = true;
        buffer[top][left + 1] = true;
    }
    if (tileId == 0 && top == 3 && left == 1) {
      success = true;
    } else {
      success = false;
    }
  }
  startGame(dynamic gameJson) {
    originJson = gameJson;
    game = new GameInfo.fromJson(originJson);
    initBuffer();
    setBuffer();
  }
  restart() {
    GameInfo originGame = new GameInfo.fromJson(originJson);
    steps.clear();
    initBuffer();
    setBuffer();
    for (int i = 0; i < game.tiles.length; ++i) {
      tileModel.setPosition[originGame.tiles[i].tileId](originGame.tiles[i].position);
    }
  }
  withdraw(Step last) {
    int location = getLocation(last.tileId);
    int originLeft = game.tiles[location].position[1];
    int originTop = game.tiles[location].position[0];
    int left = originLeft - last.position[1];
    int top = originTop - last.position[0];
    tileModel.setPosition[last.tileId]([top, left]);
    switch (game.tiles[location].block.type) {
      case BlockType.LittleSquare:
        buffer[originTop][originLeft] = false;
        buffer[top][left] = true;
        break;
      case BlockType.LargeSquare:
        buffer[originTop][originLeft] = false;
        buffer[originTop + 1][originLeft] = false;
        buffer[originTop][originLeft + 1] = false;
        buffer[originTop + 1][originLeft + 1] = false;
        buffer[top][left] = true;
        buffer[top + 1][left] = true;
        buffer[top][left + 1] = true;
        buffer[top + 1][left + 1] = true;
        break;
      case BlockType.TransRectangle:
        buffer[originTop][originLeft] = false;
        buffer[originTop + 1][originLeft] = false;
        buffer[top][left] = true;
        buffer[top + 1][left] = true;
        break;
      case BlockType.Rectangle:
        buffer[originTop][originLeft] = false;
        buffer[originTop][originLeft + 1] = false;
        buffer[top][left] = true;
        buffer[top][left + 1] = true;
        break;
    }
  }

  getLocation(int tileId) {
    for (int i = 0; i < game.tiles.length; ++i) {
      if (tileId == game.tiles[i].tileId) {
        return i;
      }
    }
  }
  initBuffer() {
    buffer = [
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];
  }
  setBuffer() {
    for (int i = 0; i < game.tiles.length; ++i) {
      switch (game.tiles[i].block.type) {
        case BlockType.LittleSquare:
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1]] = true;
          break;
        case BlockType.LargeSquare:
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1]] = true;
          buffer[game.tiles[i].position[0] + 1][game.tiles[i].position[1] + 1] =
              true;
          buffer[game.tiles[i].position[0] + 1][game.tiles[i].position[1]] =
              true;
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1] + 1] =
              true;
          break;
        case BlockType.Rectangle:
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1]] = true;
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1] + 1] =
              true;
          break;
        case BlockType.TransRectangle:
          buffer[game.tiles[i].position[0]][game.tiles[i].position[1]] = true;
          buffer[game.tiles[i].position[0] + 1][game.tiles[i].position[1]] =
              true;
          break;
      }
    }
  }
}

class StatisticsModel {
  Function timeStart;
  Function timeStop;
  Function timePause;
  Function stepPlus;
  Function allRestart;
  Function getStep;
  Function getTime;

  restart() {
    allRestart();
  }
  withdraw() {
    stepPlus(-1);
  }

  registerTimeStart(Function timeStart) {
    this.timeStart = timeStart;
  }
  registerTimeStop(Function timeStop) {
    this.timeStop = timeStop;
  }
  registerTimePause(Function timePause) {
    this.timePause = timePause;
  }
  registerStepPlus(Function stepPlus) {
    this.stepPlus = stepPlus;
  }
  registerAllRestart(Function allRestart) {
    this.allRestart = allRestart;
  }
  registerGetStep(Function getStep) {
    this.getStep = getStep;
  }
  registerGetTime(Function getTime) {
    this.getTime = getTime;
  }
}

class TileModel {
  Map<int, Function> setPosition = new Map();
  Map<int, Function> updatePosition = new Map();

  registerSetPosition(int tileId, Function setPosition) {
    this.setPosition[tileId] = setPosition;
  }
  registerUpdatePosition(int tileId, Function updatePosition) {
    this.updatePosition[tileId] = updatePosition;
  }
}
