import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinycolor/tinycolor.dart';

class FUILinearProgressBar extends StatefulWidget {
  final Duration animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double value, strokeWidth;
  final bool useGradient;

  const FUILinearProgressBar({
    Key key,
    this.animationDuration,
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
    this.strokeWidth = 7,
    this.useGradient = false,
  }) : super(key: key);

  @override
  FUILinearProgressBarState createState() {
    return FUILinearProgressBarState();
  }
}

class FUILinearProgressBarState extends State<FUILinearProgressBar>
    with SingleTickerProviderStateMixin {
  // Used in tweens where a backgroundColor isn't given.
  static const TRANSPARENT = Color(0x00000000);
  AnimationController _controller;

  Animation<double> curve;
  Tween<double> valueTween;
  Tween<Color> backgroundColorTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();

    this._controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(milliseconds: 400),
      vsync: this,
    );

    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );

    // Build the initial required tweens.
    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value,
    );

    this._controller.forward();
  }

  @override
  void didUpdateWidget(FUILinearProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      // Try to start with the previous tween's end value. This ensures that we
      // have a smooth transition from where the previous animation reached.
      double beginValue =
          this.valueTween?.evaluate(this.curve) ?? oldWidget?.value ?? 0;

      // Update the value tween.
      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );

      // Clear cached color tweens when the color hasn't changed.
      if (oldWidget?.backgroundColor != this.widget.backgroundColor) {
        this.backgroundColorTween = ColorTween(
          begin: oldWidget?.backgroundColor ?? TRANSPARENT,
          end: this.widget.backgroundColor ?? TRANSPARENT,
        );
      } else {
        this.backgroundColorTween = null;
      }

      if (oldWidget.foregroundColor != this.widget.foregroundColor) {
        this.foregroundColorTween = ColorTween(
          begin: oldWidget?.foregroundColor,
          end: this.widget.foregroundColor,
        );
      } else {
        this.foregroundColorTween = null;
      }

      this._controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
          AnimatedBuilder(
          animation: this.curve,
          child: Container(),
          builder: (context, child) {
            final backgroundColor =
                this.backgroundColorTween?.evaluate(this.curve) ??
                    this.widget.backgroundColor;
            final foregroundColor =
                this.foregroundColorTween?.evaluate(this.curve) ??
                    this.widget.foregroundColor;

            return CustomPaint(
              child: child,
              foregroundPainter: FUILinearProgressBarPainter(
                strokeWidth: widget.strokeWidth,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                useGradient: widget.useGradient,
                percentage: this.valueTween.evaluate(this.curve),
              ),
            );
          },
    );
  }
}

// Draws the progress bar.
class FUILinearProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool useGradient;

  FUILinearProgressBarPainter({
    this.backgroundColor,
    @required this.foregroundColor,
    @required this.percentage,
    double strokeWidth,
    this.useGradient = false,
  }) : this.strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width * this.percentage;
    final gradient = ui.Gradient.linear(
          Offset.zero,
          Offset(width,0),
    [
      // Colors.black,
      this.foregroundColor,
      TinyColor(this.foregroundColor).lighten(15).color,
    ],
    [
      0.7,
      1.0,
    ]
  );
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (this.useGradient) {
      foregroundPaint..shader = gradient;
    }
    // // Don't draw the background if we don't have a background color
    if (this.backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset.zero, Offset(size.width, 0), backgroundPaint);
    }

    canvas.drawLine(Offset.zero, Offset(width,0), foregroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as FUILinearProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}