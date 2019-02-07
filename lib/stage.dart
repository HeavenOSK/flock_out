import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Stage extends StatefulWidget {
  @override
  _StageState createState() => _StageState();
}

class _StageState extends State<Stage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: CircleRenderWidget(
          height: height,
          width: width,
        ),
      ),
    );
  }
}

class CircleRenderWidget extends SingleChildRenderObjectWidget {
  final double width;
  final double height;

  CircleRenderWidget({
    @required this.width,
    @required this.height,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyRenderBox(
      height: height,
      width: width,
    )..animate();
  }
}

class _MyRenderBox extends RenderBox {
  final double height;
  final double width;
  double _x = 0.0;
  double _y = 0.0;
  double _xSpeed = 3.0;
  double _ySpeed = 3.0;

  _MyRenderBox({
    @required this.height,
    @required this.width,
  })  : _x = width / 2,
        _y = height / 2;

  void animate() {
    SchedulerBinding.instance.scheduleFrameCallback((Duration timeStampe) {
      _calculateNextPosition();
      this.markNeedsPaint();
      animate();
    });
  }

  void _calculateNextPosition() {
    _x += _xSpeed;
    _y += _ySpeed;

    if (_x < 0 || width < _x) {
      _xSpeed = _xSpeed * (-1);
    }
    if (_y < 0 || height < _y) {
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
