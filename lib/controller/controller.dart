import 'package:hua_rong_dao/model/model.dart';
import 'package:hua_rong_dao/model/game_info.dart';

class Controller {
  GameModel gameModel = new GameModel();
  StatisticsModel statisticsModel = new StatisticsModel();

  setMode(String mode) {
    gameModel.mode = mode;
  }
  getMode() {
    return gameModel.mode;
  }
  getPath() {
    return gameModel.director[gameModel.mode];
  }
  setLength(int length) {
    gameModel.length = length;
  }
  getLength() {
    return gameModel.length;
  }
  setIndex(int index) {
    gameModel.index = index;
  }
  getIndex() {
    return gameModel.index;
  }
  setWidth(double width) {
    gameModel.width = width;
  }
  getWidth() {
    return gameModel.width;
  }
  getStep() {
    return statisticsModel.getStep();
  }
  getTime() {
    return statisticsModel.getTime();
  }
  moveStart(int tileId) {
    print(getIndex());
    gameModel.moveStart(tileId);
  }
  horizontalUpdate(int tileId, double dx, double marginLeft) {
    gameModel.horizontalUpdate(tileId, dx, marginLeft);
  }
  verticalUpdate(int tileId, double dy, double marginTop) {
    gameModel.verticalUpdate(tileId, dy, marginTop);
  }
  moveStop(int tileId, double marginLeft, double marginTop) {
    gameModel.moveStop(tileId, marginLeft, marginTop);
    if (gameModel.success) {
      gameModel.showSuccess();
    }
  }
  start(dynamic gameJson) {
    gameModel.startGame(gameJson);
  }
  restart() {
    statisticsModel.restart();
    gameModel.restart();
  }
  withdraw() {
    Step last = gameModel.steps.removeLast();
    if (last != null) {
      gameModel.withdraw(last);
      statisticsModel.withdraw();
    }
  }
}