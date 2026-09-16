import 'dart:ui';

enum BrickTheme { classic, red, blue }

enum BrickSize { small, medium, large }

class GameSettings {
  const GameSettings({
    this.theme = BrickTheme.red,
    this.size = BrickSize.medium,
  });

  final BrickTheme theme;
  final BrickSize size;

  GameSettings copyWith({BrickTheme? theme, BrickSize? size}) => GameSettings(
        theme: theme ?? this.theme,
        size: size ?? this.size,
      );

  String get themeLabel => switch (theme) {
        BrickTheme.classic => 'Clássico',
        BrickTheme.red => 'Vermelho',
        BrickTheme.blue => 'Azul',
      };

  String get sizeLabel => switch (size) {
        BrickSize.small => 'Pequeno',
        BrickSize.medium => 'Médio',
        BrickSize.large => 'Grande',
      };

  List<Color> get colors => switch (theme) {
        BrickTheme.classic => const [Color(0xfff59e0b), Color(0xff22c55e), Color(0xff3b82f6)],
        BrickTheme.red => const [Color(0xffef4444), Color(0xfff97316), Color(0xffec4899)],
        BrickTheme.blue => const [Color(0xff0ea5e9), Color(0xff2563eb), Color(0xff8b5cf6)],
      };

  int get rows => switch (size) {
        BrickSize.small => 6,
        BrickSize.medium => 5,
        BrickSize.large => 4,
      };
}

const List<List<List<int>>> levelWalls = [
  [
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
  ],
  [
    [1, 1, 0, 1, 1, 1, 0, 1, 1],
    [1, 0, 1, 1, 0, 1, 1, 0, 1],
    [0, 1, 1, 0, 1, 0, 1, 1, 0],
    [1, 0, 1, 1, 0, 1, 1, 0, 1],
  ],
  [
    [0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
  ],
  [
    [1, 0, 1, 0, 1, 0, 1, 0, 1],
    [0, 1, 0, 1, 0, 1, 0, 1, 0],
    [1, 0, 1, 0, 1, 0, 1, 0, 1],
    [0, 1, 0, 1, 0, 1, 0, 1, 0],
  ],
  [
    [0, 0, 0, 0, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0, 0, 0],
  ],
];
