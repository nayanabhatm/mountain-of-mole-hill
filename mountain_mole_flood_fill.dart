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
    Coord startCoord = _findStartCoord(area, i) ?? Coord(0, 0);
    floodFill(area, startCoord);
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
    // Find the connected characters of the outer space
    if (area[row][col] == 'o' || area[row][col] == '.') {
      area[row][col] = '1'; // marking the node as visited
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

Coord? _findStartCoord(List<List<String>> area, int startRow) {
  // Find the starting index of the outer space
  for (int j = 0; j < 16; j++) {
    if (area[startRow][j] == '.') {
      return Coord(startRow, j);
    }
  }
}

bool _checkIfVisited(List<List<String>> area, int x, int y) {
  return (area[x][y] != '1' && (area[x][y] == 'o' || area[x][y] == '.'));
}
