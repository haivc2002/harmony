import 'dart:math' as math;
import 'package:harmony/base_project/package_widget.dart';

class WidgetSparkling extends StatefulWidget {
  final Widget child;
  const WidgetSparkling({super.key, required this.child});

  @override
  State<WidgetSparkling> createState() => _WidgetSparklingState();
}

class _WidgetSparklingState extends State<WidgetSparkling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Sparkle> sparkles = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _generateSparkles();
    _controller.addListener(() {
      setState(() {
        for (var sparkle in sparkles) {
          sparkle.update();
          if (sparkle.scale <= 0.7) {
            sparkle.randomizePosition();
          }
        }
      });
    });
  }

  void _generateSparkles() {
    sparkles = List.generate(5, (index) {
      return Sparkle(
        position: Offset(
          math.Random().nextDouble() * 200,
          math.Random().nextDouble() * 200,
        ),
        scale: 1.0,
        opacity: math.Random().nextDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: SparklePainter(sparkles),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Sparkle {
  Offset position;
  double scale;
  double opacity;

  Sparkle({
    required this.position,
    required this.scale,
    required this.opacity,
  });

  void update() {
    scale = 1 + math.sin(DateTime.now().millisecondsSinceEpoch * 0.005) * 0.3;
    opacity = 0.8;
  }

  void randomizePosition() {
    position = Offset(
      math.Random().nextDouble() * 200,
      math.Random().nextDouble() * 200,
    );
  }
}

class SparklePainter extends CustomPainter {
  final List<Sparkle> sparkles;

  SparklePainter(this.sparkles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var sparkle in sparkles) {
      paint.color = Colors.white.withOpacity(sparkle.opacity);
      _drawFourPointStar(canvas, sparkle.position, sparkle.scale, paint);
    }
  }

  void _drawFourPointStar(Canvas canvas, Offset center, double scale, Paint paint) {
    final double outerRadius = 12 * scale;
    final double innerRadius = outerRadius / 2.5;

    final path = Path();

    for (int i = 0; i < 8; i++) {
      double radius = i.isEven ? outerRadius : innerRadius;
      double angle = -math.pi / 2 + (i * math.pi / 4);

      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




