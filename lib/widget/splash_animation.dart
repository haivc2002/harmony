import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harmony/theme/my_rive.dart';
import 'package:rive/rive.dart' as rive;

class SplashAnimation extends StatefulWidget {
  final Widget child;
  const SplashAnimation({super.key, required this.child});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  bool _showTweenAnimation = false;
  bool _hideBackground = false;
  final int _milliseconds = 4000;
  final int _seconds = 5;
  rive.RiveFile? _file;

  @override
  void initState() {
    super.initState();
    _preload().whenComplete(() {
      Timer(Duration(milliseconds: _milliseconds), () {
        setState(()=> _showTweenAnimation = true);
      });
      Timer(Duration(seconds: _seconds), () {
        setState(()=> _hideBackground = true);
      });
    });
  }

  Future<void> _preload() async {
    rootBundle.load(MyRive.splash).then((data) async {
        setState(()=> _file = rive.RiveFile.import(data));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file != null ? Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            tween: Tween<double>(begin: _showTweenAnimation ? 0 : -150, end: _showTweenAnimation ? 0 : -150),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: widget.child,
              );
            },
          ),
          if (!_hideBackground)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _hideBackground ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: rive.RiveAnimation.direct(_file!, fit: BoxFit.fill),
              ),
            ),
        ],
      ),
    ) : const ColoredBox(color: Colors.black);
  }
}
