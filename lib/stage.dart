import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Stage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final deviceHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    final minHiehgt = padding.top;
    final maxHeight = deviceHeight - padding.bottom;
    return Scaffold(
      body: Center(
        child: CircleRenderWidget(
          minHeight: minHiehgt,
          maxHeight: maxHeight,
          width: deviceWidth,
        ),
      ),
    );
  }
}

class CircleRenderWidget extends SingleChildRenderObjectWidget {
  final double width;
  final double maxHeight;
  final double minHeight;

  CircleRenderWidget({
    @required this.minHeight,
    @required this.width,
    @required this.maxHeight,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyRenderBox(
      maxHeight: maxHeight,
      minHeight: minHeight,
      width: width,
    )..animate();
  }
}

class _MyRenderBox extends RenderBox {
  final double maxHeight;
  final double minHeight;
  final double width;
  double _x = 0.0;
  double _y = 0.0;
  double _xSpeed = 3.0;
  double _ySpeed = 3.0;

  _MyRenderBox({
    @required this.maxHeight,
    @required this.minHeight,
    @required this.width,
  })  : _x = width / 2,
        _y = maxHeight / 2;

  void animate() {
    SchedulerBinding.instance.scheduleFrameCallback((Duration timeStampe) {
      _calculateNextPosition();
      this.markNeedsPaint();
      animate();
    });
  }

  @override
  performLayout() {
    this.size = Size(width, maxHeight);
  }

  void _calculateNextPosition() {
    _x += _xSpeed;
    _y += _ySpeed;

    if (_x < 0 || width < _x) {
      _xSpeed = _xSpeed * (-1);
    }
    if (_y < minHeight || maxHeight < _y) {
      _ySpeed = _ySpeed * (-1);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;
    double dx = offset.dx;
    double dy = offset.dy;

    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = HSVColor.fromAHSV(1.0, 200.0, 0.6, 1.0).toColor();
    Offset c = Offset(dx + _x, dy + _y);
    canvas.drawCircle(c, 8.0, paint);
  }
}
