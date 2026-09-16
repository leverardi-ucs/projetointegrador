import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'game_models.dart';

const _pink = Color(0xffffb8bd);
const _buttonGray = Color(0xffbdbdbd);
const _bottomBlue = Color(0xffc9e8fb);

class PillButton extends StatelessWidget {
  const PillButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.compact = false});
  final String label;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: compact ? 54 : 68,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _buttonGray,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: const StadiumBorder(),
            textStyle: TextStyle(
                fontSize: compact ? 24 : 28, fontWeight: FontWeight.w400),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      );
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              height: .95),
        ),
      );
}

void main() => runApp(const BrickBreakerApp());

class BrickBreakerApp extends StatefulWidget {
  const BrickBreakerApp({super.key});

  @override
  State<BrickBreakerApp> createState() => _BrickBreakerAppState();
}

class _BrickBreakerAppState extends State<BrickBreakerApp> {
  GameSettings settings = const GameSettings();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Brick Breaker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: _pink),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: HomePage(
          settings: settings,
          onSettingsChanged: (value) => setState(() => settings = value),
        ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage(
      {super.key, required this.settings, required this.onSettingsChanged});

  final GameSettings settings;
  final ValueChanged<GameSettings> onSettingsChanged;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _LogoBlocks(),
                    const ScreenTitle('BLOCK\nBREAKER'),
                    const Spacer(),
                    PillButton(
                        label: 'JOGAR',
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => GamePage(settings: settings)))),
                    const SizedBox(height: 22),
                    PillButton(
                        label: 'Integrantes',
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const TeamPage()))),
                    const SizedBox(height: 22),
                    PillButton(
                        label: 'Configurações',
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => SettingsPage(
                                    settings: settings,
                                    onSave: onSettingsChanged)))),
                    const Spacer(),
                    const _BottomBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.settings, required this.onSave});
  final GameSettings settings;
  final ValueChanged<GameSettings> onSave;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late GameSettings value;
  @override
  void initState() {
    super.initState();
    value = widget.settings;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 26, 28, 20),
          child: ListView(children: [
            const ScreenTitle('CONFIGURAÇÕES'),
            const SizedBox(height: 52),
            const Text('Padrão de Cores', style: TextStyle(fontSize: 27)),
            const SizedBox(height: 10),
            RadioGroup<BrickTheme>(
                groupValue: value.theme,
                onChanged: (choice) {
                  if (choice != null) {
                    setState(() => value = value.copyWith(theme: choice));
                  }
                },
                child: Column(
                    children: BrickTheme.values
                        .map((theme) => _OptionRow<BrickTheme>(
                              value: theme,
                              label: GameSettings(theme: theme).themeLabel,
                              preview: _ThemePreview(
                                  colors: GameSettings(theme: theme).colors),
                              onChanged: (choice) => setState(
                                  () => value = value.copyWith(theme: choice)),
                            ))
                        .toList())),
            const SizedBox(height: 36),
            const Text('Tamanho dos Tijolos', style: TextStyle(fontSize: 27)),
            const SizedBox(height: 10),
            RadioGroup<BrickSize>(
                groupValue: value.size,
                onChanged: (choice) {
                  if (choice != null) {
                    setState(() => value = value.copyWith(size: choice));
                  }
                },
                child: Column(
                    children: BrickSize.values
                        .map((size) => _OptionRow<BrickSize>(
                              value: size,
                              label: GameSettings(size: size).sizeLabel,
                              preview: _SizePreview(size),
                              onChanged: (choice) => setState(
                                  () => value = value.copyWith(size: choice)),
                            ))
                        .toList())),
            const SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46),
                child: PillButton(
                    label: 'SALVAR',
                    onPressed: () {
                      widget.onSave(value);
                      Navigator.pop(context);
                    })),
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: 180,
                    child: PillButton(
                        compact: true,
                        label: '← Voltar',
                        onPressed: () => Navigator.pop(context)))),
          ]),
        )),
      );
}

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});
  static const members = [
    'Luis Eduardo Verardi',
    'Thobias Cavalli',
    'Joe Sander',
    'João Gabriel Silvestrin'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(42, 38, 42, 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const ScreenTitle('INTEGRANTES'),
            const Spacer(),
            ...members.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: PillButton(label: name, onPressed: () {}))),
            Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: 190,
                    child: PillButton(
                        compact: true,
                        label: '← Voltar',
                        onPressed: () => Navigator.pop(context)))),
          ]),
        )),
      );
}

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.settings});
  final GameSettings settings;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  final GameState _game = GameState();

  @override
  void initState() {
    super.initState();
    _game.start(widget.settings);
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration elapsed) {
    if (_last != Duration.zero) {
      _game.update(
          (elapsed - _last).inMicroseconds / Duration.microsecondsPerSecond);
    }
    _last = elapsed;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _restart() {
    setState(() {
      _game.start(widget.settings, level: _game.level);
      _last = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 10),
            child: ScreenTitle('NÍVEL ${_game.level + 1}')),
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          _game.resize(constraints.biggest);
          return Stack(fit: StackFit.expand, children: [
            GestureDetector(
              onHorizontalDragUpdate: (details) =>
                  setState(() => _game.movePaddle(details.localPosition.dx)),
              onTapDown: (details) =>
                  setState(() => _game.movePaddle(details.localPosition.dx)),
              child: CustomPaint(
                  painter: GamePainter(_game), child: const SizedBox.expand()),
            ),
            if (_game.gameOver || _game.completed)
              _GameOverPanel(
                completed: _game.completed,
                onRestart: _restart,
                onNext: () => setState(() {
                  _game.start(widget.settings,
                      level: (_game.level + 1) % levelWalls.length);
                  _last = Duration.zero;
                }),
                onMenu: () => Navigator.pop(context),
              ),
          ]);
        })),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 7, 16, 14),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: _bottomBlue,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              child: Row(children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text('Pontos: ${_game.score}'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text('Vidas: ${_game.lives}'),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ])),
    );
  }
}

class Brick {
  Brick(this.rect, this.color);
  Rect rect;
  final Color color;
  bool alive = true;
}

class GameState {
  final Random _random = Random();
  Size size = Size.zero;
  int level = 0;
  int score = 0;
  int lives = 3;
  double paddleX = 0;
  double ballX = 0;
  double ballY = 0;
  double vx = 180;
  double vy = 230;
  double paddleWidth = 95;
  final double paddleHeight = 14;
  final double ballRadius = 8;
  bool gameOver = false;
  bool completed = false;
  List<Brick> bricks = [];
  GameSettings settings = const GameSettings();
  void start(GameSettings value, {int level = 0}) {
    settings = value;
    this.level = level;
    score = 0;
    lives = 3;
    gameOver = false;
    completed = false;
    if (size != Size.zero) _setupLevel();
  }

  void resize(Size value) {
    if (value == size || value.isEmpty) return;
    final previousSize = size;
    size = value;
    if (previousSize.isEmpty) {
      _setupLevel();
      return;
    }
    final scaleX = size.width / previousSize.width;
    final scaleY = size.height / previousSize.height;
    movePaddle(paddleX * scaleX);
    ballX =
        (ballX * scaleX).clamp(ballRadius, size.width - ballRadius).toDouble();
    ballY *= scaleY;
    for (final brick in bricks) {
      brick.rect = Rect.fromLTWH(
        brick.rect.left * scaleX,
        brick.rect.top * scaleY,
        brick.rect.width * scaleX,
        brick.rect.height * scaleY,
      );
    }
  }

  void _setupLevel() {
    paddleWidth = switch (settings.size) {
      BrickSize.small => 78,
      BrickSize.medium => 95,
      BrickSize.large => 116
    };
    paddleX = size.width / 2;
    ballX = paddleX;
    ballY = size.height - 60;
    vx = _random.nextBool() ? 180 : -180;
    vy = -230;
    bricks = [];
    final wall = levelWalls[level];
    final gap = 4.0;
    final brickWidth = (size.width - 32 - gap * 8) / 9;
    final brickHeight = switch (settings.size) {
      BrickSize.small => 19.0,
      BrickSize.medium => 25.0,
      BrickSize.large => 31.0
    };
    for (var row = 0; row < wall.length; row++) {
      for (var col = 0; col < wall[row].length; col++) {
        if (wall[row][col] == 1) {
          bricks.add(Brick(
              Rect.fromLTWH(16 + col * (brickWidth + gap),
                  26 + row * (brickHeight + gap), brickWidth, brickHeight),
              settings.colors[row % settings.colors.length]));
        }
      }
    }
  }

  void movePaddle(double x) {
    paddleX = x.clamp(paddleWidth / 2, size.width - paddleWidth / 2).toDouble();
  }

  void update(double dt) {
    if (size == Size.zero || gameOver || completed) return;
    ballX += vx * dt;
    ballY += vy * dt;
    if (ballX - ballRadius < 0 || ballX + ballRadius > size.width) {
      vx = -vx;
      ballX = ballX.clamp(ballRadius, size.width - ballRadius).toDouble();
    }
    if (ballY - ballRadius < 0) {
      vy = vy.abs();
      ballY = ballRadius;
    }
    final paddle = Rect.fromCenter(
        center: Offset(paddleX, size.height - 30),
        width: paddleWidth,
        height: paddleHeight);
    if (vy > 0 &&
        Rect.fromCircle(center: Offset(ballX, ballY), radius: ballRadius)
            .overlaps(paddle)) {
      final hit = (ballX - paddleX) / (paddleWidth / 2);
      vx = 250 * hit;
      vy = -vy.abs();
      ballY = paddle.top - ballRadius;
    }
    for (final brick in bricks.where((brick) => brick.alive)) {
      if (Rect.fromCircle(center: Offset(ballX, ballY), radius: ballRadius)
          .overlaps(brick.rect)) {
        brick.alive = false;
        score += 10;
        vy = -vy;
        break;
      }
    }
    if (bricks.every((brick) => !brick.alive)) {
      if (level == levelWalls.length - 1) {
        completed = true;
      } else {
        level++;
        _setupLevel();
      }
    }
    if (ballY - ballRadius > size.height) {
      lives--;
      if (lives <= 0) {
        gameOver = true;
      } else {
        ballX = paddleX;
        ballY = size.height - 60;
        vy = -230;
        vx = 180;
      }
    }
  }
}

class GamePainter extends CustomPainter {
  GamePainter(this.game);
  final GameState game;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
    for (final brick in game.bricks.where((brick) => brick.alive)) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(brick.rect, const Radius.circular(4)),
          Paint()..color = brick.color);
    }
    final paddle = Rect.fromCenter(
        center: Offset(game.paddleX, size.height - 30),
        width: game.paddleWidth,
        height: game.paddleHeight);
    canvas.drawRRect(RRect.fromRectAndRadius(paddle, const Radius.circular(9)),
        Paint()..color = _bottomBlue);
    canvas.drawCircle(Offset(game.ballX, game.ballY), game.ballRadius,
        Paint()..color = const Color(0xfff8d76b));
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) => true;
}

class _LogoBlocks extends StatelessWidget {
  const _LogoBlocks();
  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final unit = constraints.maxWidth / 4;
        return SizedBox(
          height: unit * 1.55,
          child: Stack(children: [
            Positioned(left: 0, top: unit * .78, child: _LogoBlock(unit)),
            Positioned(left: unit, top: 0, child: _LogoBlock(unit)),
            Positioned(left: unit * 2, top: 0, child: _LogoBlock(unit)),
            Positioned(
                left: unit * 2, top: unit * .78, child: _LogoBlock(unit)),
            Positioned(
                left: unit * 3, top: unit * .78, child: _LogoBlock(unit)),
          ]),
        );
      });
}

class _LogoBlock extends StatelessWidget {
  const _LogoBlock(this.unit);
  final double unit;
  @override
  Widget build(BuildContext context) =>
      Container(width: unit, height: unit * .78, color: _pink);
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();
  @override
  Widget build(BuildContext context) => Container(
      height: 48,
      decoration: const BoxDecoration(
          color: _bottomBlue,
          borderRadius: BorderRadius.all(Radius.circular(14))));
}

class _OptionRow<T> extends StatelessWidget {
  const _OptionRow(
      {required this.value,
      required this.label,
      required this.preview,
      required this.onChanged});
  final T value;
  final String label;
  final Widget preview;
  final ValueChanged<T> onChanged;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onChanged(value),
        child: SizedBox(
            height: 58,
            child: Row(children: [
              Radio<T>(
                  value: value,
                  activeColor: Colors.black,
                  fillColor: WidgetStateProperty.all(_buttonGray)),
              Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 26))),
              Flexible(child: FittedBox(fit: BoxFit.scaleDown, child: preview)),
            ])),
      );
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.colors});
  final List<Color> colors;
  @override
  Widget build(BuildContext context) => Row(
      children: List.generate(
          4,
          (index) => Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 9),
              color: colors[index % colors.length])));
}

class _SizePreview extends StatelessWidget {
  const _SizePreview(this.size);
  final BrickSize size;
  @override
  Widget build(BuildContext context) {
    final side = switch (size) {
      BrickSize.small => 32.0,
      BrickSize.medium => 48.0,
      BrickSize.large => 64.0
    };
    return Container(
        width: 70,
        height: 58,
        alignment: Alignment.center,
        child: Container(width: side, height: side, color: _pink));
  }
}

class _GameOverPanel extends StatelessWidget {
  const _GameOverPanel(
      {required this.completed,
      required this.onRestart,
      required this.onNext,
      required this.onMenu});
  final bool completed;
  final VoidCallback onRestart;
  final VoidCallback onNext;
  final VoidCallback onMenu;
  @override
  Widget build(BuildContext context) => Center(
          child: Container(
        width: 300,
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 26),
        decoration: BoxDecoration(
            color: const Color(0xffe6e6e6).withValues(alpha: .94),
            borderRadius: BorderRadius.circular(18)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ScreenTitle(completed ? 'VOCÊ VENCEU!' : 'GAME OVER'),
          const SizedBox(height: 24),
          PillButton(
              compact: true, label: 'Reiniciar Nível', onPressed: onRestart),
          const SizedBox(height: 20),
          PillButton(compact: true, label: 'Próximo Nível', onPressed: onNext),
          const SizedBox(height: 20),
          PillButton(compact: true, label: 'Voltar ao Menu', onPressed: onMenu),
        ]),
      ));
}
