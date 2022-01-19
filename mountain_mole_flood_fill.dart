import 'dart:io';

class Coord {
  int x;
  int y;
  Coord(this.x, this.y);
}

String readLineSync() {
  String? s = stdin.readLineSync();
  return s == null ? '' : s;
}

void main() {
  List<List<String>> area = [];
  int molesCount = 0;

  for (int i = 0; i < 16; i++) {
    String line = readLineSync();
    area.add(line.split(''));
  }

  for (int i = 0; i < 16; i++) {
    floodFill(area, _findStartIndex(area, i) ?? Coord(0, 0));
  }

  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 16; j++) {
      if (area[i][j] == 'o') {
        molesCount++;
      }
    }
  }
  print(molesCount);
}

void floodFill(List<List<String>> area, Coord startCoord) {
  List<Coord> stack = [];
  stack.add(startCoord);

  while (stack.length > 0) {
    Coord coord = stack.removeLast();
    int row = coord.x;
    int col = coord.y;
    if (area[row][col] == 'o' || area[row][col] == '.') {
      area[row][col] = '1';
      if (row + 1 < 16 && _checkIfVisited(area, row + 1, col)) {
        stack.add(Coord(row + 1, col));
      }
      if (row - 1 >= 0 && _checkIfVisited(area, row - 1, col)) {
        stack.add(Coord(row - 1, col));
      }
      if (col + 1 < 16 && _checkIfVisited(area, row, col + 1)) {
        stack.add(Coord(row, col + 1));
      }
      if (col - 1 >= 0 && _checkIfVisited(area, row, col - 1)) {
        stack.add(Coord(row, col - 1));
      }
    }
  }
}

Coord? _findStartIndex(List<List<String>> area, int startRow) {
  for (int i = startRow + 1; i < 16; i++) {
    for (int j = 0; j < 16; j++) {
      if (area[i][j] == '.') {
        return Coord(i, j);
      }
    }
  }
}

bool _checkIfVisited(List<List<String>> area, int x, int y) {
  return (area[x][y] != '1' && (area[x][y] == 'o' || area[x][y] == '.'));
}
