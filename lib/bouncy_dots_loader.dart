import 'dart:math';
import 'package:flutter/material.dart';

/// Types of loaders available in this package.
/// All are dots-based animations.
enum AnimatedLoaderType {
  bouncingDots,
  waveDots,
  scalingDots,
  fadingDots,
}

/// Main wrapper widget to choose a loader style.
class BouncyDotsLoader extends StatelessWidget {
  final AnimatedLoaderType type;
  final double size;
  final Color color;
  final Duration duration;

  const BouncyDotsLoader({
    super.key,
    this.type = AnimatedLoaderType.bouncingDots,
    this.size = 40,
    this.color = Colors.blue,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AnimatedLoaderType.bouncingDots:
        return BouncingDotsLoader(
          dotSize: size / 4,
          color: color,
          duration: duration,
        );

      case AnimatedLoaderType.waveDots:
        return WaveDotsLoader(
          dotSize: size / 4,
          color: color,
          duration: duration,
        );

      case AnimatedLoaderType.scalingDots:
        return ScalingDotsLoader(
          dotSize: size / 4,
          color: color,
          duration: duration,
        );

      case AnimatedLoaderType.fadingDots:
        return FadingDotsLoader(
          dotSize: size / 4,
          color: color,
          duration: duration,
        );
    }
  }
}

/// ------------------------------------------------------------------
/// 1. BOUNCING DOTS LOADER (vertical bounce wave + visibility)
/// ------------------------------------------------------------------
class BouncingDotsLoader extends StatefulWidget {
  /// Size of each dot.
  final double dotSize;

  /// Color of the dots.
  final Color color;

  /// Number of dots.
  final int dotCount;

  /// How long one full animation cycle takes.
  final Duration duration;

  /// Whether the loader is visible.
  /// If false, it fades out and shrinks but keeps layout stable.
  final bool visible;

  const BouncingDotsLoader({
    super.key,
    this.dotSize = 8,
    this.color = Colors.blue,
    this.dotCount = 3,
    this.duration = const Duration(milliseconds: 1200),
    this.visible = true,
  });

  @override
  State<BouncingDotsLoader> createState() => _BouncingDotsLoaderState();
}

class _BouncingDotsLoaderState extends State<BouncingDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dotSize = widget.dotSize;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: widget.visible ? 1.0 : 0.0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 250),
        scale: widget.visible ? 1.0 : 0.7,
        child: SizedBox(
          height: dotSize * 3,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = _controller.value; // 0..1

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.dotCount, (index) {
                  // Phase shift per dot (offset in wave).
                  final phase = (index / widget.dotCount) * 2 * pi;
                  final wave = sin(t * 2 * pi + phase); // -1..1

                  final dy = -wave * dotSize; // vertical offset
                  final scale = 0.8 + 0.2 * (wave + 1) / 2; // 0.8..1.0
                  final opacity = 0.4 + 0.6 * (wave + 1) / 2; // 0.4..1.0

                  return Transform.translate(
                    offset: Offset(0, dy),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: dotSize / 4),
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: Container(
                            width: dotSize,
                            height: dotSize,
                            decoration: BoxDecoration(
                              color: widget.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------------
/// 2. WAVE DOTS LOADER (side-to-side wave)
/// ------------------------------------------------------------------
class WaveDotsLoader extends StatefulWidget {
  final double dotSize;
  final Color color;
  final int dotCount;
  final Duration duration;
  final bool visible;

  const WaveDotsLoader({
    super.key,
    this.dotSize = 8,
    this.color = Colors.blue,
    this.dotCount = 4,
    this.duration = const Duration(milliseconds: 1400),
    this.visible = true,
  });

  @override
  State<WaveDotsLoader> createState() => _WaveDotsLoaderState();
}

class _WaveDotsLoaderState extends State<WaveDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.dotSize;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: widget.visible ? 1.0 : 0.0,
      child: SizedBox(
        height: dotSize * 3,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value; // 0..1

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.dotCount, (index) {
                final phase = (index / widget.dotCount) * 2 * pi;
                final wave = sin(t * 2 * pi + phase); // -1..1

                final dy = wave * (dotSize * 0.6); // small up/down wave
                final opacity =
                    0.5 + 0.5 * (cos(t * 2 * pi + phase) + 1) / 2; // 0.5..1

                return Transform.translate(
                  offset: Offset(0, dy),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: dotSize / 5),
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------------
/// 3. SCALING DOTS LOADER (zoom in/out)
/// ------------------------------------------------------------------
class ScalingDotsLoader extends StatefulWidget {
  final double dotSize;
  final Color color;
  final int dotCount;
  final Duration duration;
  final bool visible;

  const ScalingDotsLoader({
    super.key,
    this.dotSize = 8,
    this.color = Colors.blue,
    this.dotCount = 3,
    this.duration = const Duration(milliseconds: 1000),
    this.visible = true,
  });

  @override
  State<ScalingDotsLoader> createState() => _ScalingDotsLoaderState();
}

class _ScalingDotsLoaderState extends State<ScalingDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.dotSize;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: widget.visible ? 1.0 : 0.0,
      child: SizedBox(
        height: dotSize * 3,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value; // 0..1

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.dotCount, (index) {
                final phase = (index / widget.dotCount) * 2 * pi;
                final wave = sin(t * 2 * pi + phase); // -1..1

                final scale = 0.6 + 0.4 * (wave + 1) / 2; // 0.6..1.0
                final opacity = 0.4 + 0.6 * (wave + 1) / 2; // 0.4..1.0

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: dotSize / 4),
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------------
/// 4. FADING DOTS LOADER (only opacity)
/// ------------------------------------------------------------------
class FadingDotsLoader extends StatefulWidget {
  final double dotSize;
  final Color color;
  final int dotCount;
  final Duration duration;
  final bool visible;

  const FadingDotsLoader({
    super.key,
    this.dotSize = 8,
    this.color = Colors.blue,
    this.dotCount = 3,
    this.duration = const Duration(milliseconds: 900),
    this.visible = true,
  });

  @override
  State<FadingDotsLoader> createState() => _FadingDotsLoaderState();
}

class _FadingDotsLoaderState extends State<FadingDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.dotSize;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: widget.visible ? 1.0 : 0.0,
      child: SizedBox(
        height: dotSize * 3,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value; // 0..1

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.dotCount, (index) {
                final phase = (index / widget.dotCount);
                // 0..1 phase per dot, shifted
                final localT = (t + phase) % 1.0;

                // ease in/out fade
                final opacity = Curves.easeInOut.transform(
                  localT < 0.5 ? localT * 2 : (1 - localT) * 2,
                ); // 0..1

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: dotSize / 4),
                  child: Opacity(
                    opacity: 0.3 + 0.7 * opacity, // keep minimum 0.3
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
