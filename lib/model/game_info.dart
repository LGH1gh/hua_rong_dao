enum BlockType { LittleSquare, LargeSquare, Rectangle, TransRectangle}

const BLOCK_SHAPES = {
  BlockType.LargeSquare: [2, 2],
  BlockType.LittleSquare: [1, 1],
  BlockType.Rectangle: [2, 1],
  BlockType.TransRectangle: [1, 2]
};

class Block {
  Block(this.type, this.name);
  BlockType type;
  String name;
}

class TileInfo {
  TileInfo(this.tileId, this.block, this.position);
  int tileId;
  Block block;
  List<int> position;

}


class GameInfo {
  List<TileInfo> tiles = new List();
  String name;
  String description;
  int bestStep;
  int bestTime;

  GameInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bestTime = json['bestTime'];
    bestStep = json['bestStep'];
    List info = json['info'];
    for (int i = 0; i < info.length; ++i) {
      BlockType type;
      switch (info[i]['block']['type']) {
        case 'LargeSquare':
          type = BlockType.LargeSquare;
          break;
        case 'LittleSquare':
          type = BlockType.LittleSquare;
          break;
        case 'Rectangle':
          type = BlockType.Rectangle;
          break;
        case 'TransRectangle':
          type = BlockType.TransRectangle;
          break;
      }
      Block tempBlock = new Block(type, info[i]['block']['name']);
      List<int> position = new List();
      position.add(info[i]['position'][0]);
      position.add(info[i]['position'][1]);
      TileInfo tempTile = new TileInfo(info[i]['tileId'], tempBlock, position);
      tiles.add(tempTile);
    }
  }
}

class Step {
  int tileId;
  List<int> position;
  Step(this.tileId, this.position);
}
