import 'dart:math';

import 'package:flutter/material.dart';

enum Weather { sunny, rainy }

// ---------------------------------------------------------------------------
// Particle model
// ---------------------------------------------------------------------------

class _Particle {
  double x;
  double y;
  double speed;
  double size;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
  });
}

// ---------------------------------------------------------------------------
// WeatherBackground – full-screen animated background with gradient + particles
// ---------------------------------------------------------------------------

class WeatherBackground extends StatefulWidget {
  const WeatherBackground({super.key, required this.weather});

  final Weather weather;

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<_Particle> _particles = [];
  final _random = Random();

  static const _sunnyCount = 45;
  static const _rainyCount = 60;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _resetParticles();
  }

  @override
  void didUpdateWidget(covariant WeatherBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weather != widget.weather) {
      _resetParticles();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetParticles() {
    final count =
        widget.weather == Weather.sunny ? _sunnyCount : _rainyCount;
    _particles = List.generate(count, (_) => _newParticle(randomY: true));
  }

  _Particle _newParticle({bool randomY = false}) {
    final isSunny = widget.weather == Weather.sunny;
    return _Particle(
      x: _random.nextDouble(),
      y: randomY ? _random.nextDouble() : 0,
      speed: isSunny
          ? 0.0008 + _random.nextDouble() * 0.0012
          : 0.006 + _random.nextDouble() * 0.008,
      size: isSunny
          ? 2.0 + _random.nextDouble() * 4.0
          : 1.0 + _random.nextDouble() * 2.0,
      opacity: 0.3 + _random.nextDouble() * 0.5,
    );
  }

  void _tick(Size size) {
    final isSunny = widget.weather == Weather.sunny;
    for (var i = 0; i < _particles.length; i++) {
      final p = _particles[i];
      if (isSunny) {
        p.y -= p.speed; // float upward
        p.x += sin(p.y * 8) * 0.0004; // gentle sway
        if (p.y < -0.05) {
          _particles[i] = _newParticle()..y = 1.05;
        }
      } else {
        p.y += p.speed; // fall downward
        p.x += 0.0003; // slight wind
        if (p.y > 1.05) {
          _particles[i] = _newParticle()..y = -0.05;
        }
      }
    }
  }

  // Gradient colours per weather
  LinearGradient get _gradient => widget.weather == Weather.sunny
      ? const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4FC3F7), Color(0xFFB3E5FC)],
        )
      : const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF546E7A), Color(0xFF90A4AE)],
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            _tick(size);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(gradient: _gradient),
              child: CustomPaint(
                painter: _ParticlePainter(
                  particles: _particles,
                  weather: widget.weather,
                ),
                size: size,
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// CustomPainter
// ---------------------------------------------------------------------------

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.particles, required this.weather});

  final List<_Particle> particles;
  final Weather weather;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = weather == Weather.sunny
            ? Colors.yellow.withValues(alpha: p.opacity)
            : Colors.white.withValues(alpha: p.opacity);

      final dx = p.x * size.width;
      final dy = p.y * size.height;

      if (weather == Weather.sunny) {
        canvas.drawCircle(Offset(dx, dy), p.size, paint);
      } else {
        canvas.drawLine(
          Offset(dx, dy),
          Offset(dx + 0.5, dy + p.size * 5),
          paint..strokeWidth = p.size * 0.6,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
