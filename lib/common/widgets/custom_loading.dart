import 'dart:math';

import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  final double size;
  final Duration duration;
  final List<Color> colors;

  const CustomLoading({
    super.key,
    this.size = 30.0,
    this.duration = const Duration(milliseconds: 2000),
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
    ],
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _ballCount = 5;
  final List<double> _ballPositions = [];
  final List<double> _ballOpacities = [];
  final List<double> _ballScales = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    // Initialize positions and animations
    for (int i = 0; i < _ballCount; i++) {
      _ballPositions.add(0.0);
      _ballOpacities.add(0.0);
      _ballScales.add(0.5);
    }

    _controller.addListener(() {
      final value = _controller.value;
      setState(() {
        for (int i = 0; i < _ballCount; i++) {
          // Offset each ball's animation
          double ballValue = (value - (i * 0.15)) % 1.0;
          if (ballValue < 0) ballValue += 1.0;

          // Position from left to right
          _ballPositions[i] = -0.2 + ballValue * 1.4;

          // Fade in/out effect
          _ballOpacities[i] = 1.0;
          if (_ballPositions[i] < 0) {
            _ballOpacities[i] = 1.0 + _ballPositions[i] * 5;
          } else if (_ballPositions[i] > 1.0) {
            _ballOpacities[i] = 1.0 - (_ballPositions[i] - 1.0) * 5;
          }

          // Bouncing effect in the middle
          if (ballValue > 0.3 && ballValue < 0.7) {
            double bounceValue = (ballValue - 0.3) / 0.4;
            _ballScales[i] = 0.8 + 0.4 * sin(bounceValue * pi);
          } else {
            _ballScales[i] = 0.8;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size * (_ballCount + 2),
        height: widget.size * 1.5,
        child: Stack(
          clipBehavior: Clip.none,
          children: List.generate(_ballCount, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: _ballPositions[index] * widget.size * _ballCount * 0.8,
                  bottom: 0,
                  child: Transform.translate(
                    offset: Offset(0, -20 * (1 - _ballScales[index])),
                    child: Transform.scale(
                      scale: _ballScales[index],
                      child: Opacity(
                        opacity: _ballOpacities[index].clamp(0.0, 1.0),
                        child: Container(
                          width: widget.size,
                          height: widget.size,
                          decoration: BoxDecoration(
                            color: widget.colors[index % widget.colors.length],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget
                                    .colors[index % widget.colors.length]
                                    .withOpacity(0.5),
                                blurRadius: 6.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
