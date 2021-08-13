import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DiagonalPainter extends CustomPainter {
  ui.Image assetImage;
  // DiagonalPainter(this.assetImage) : super();
  DiagonalPainter() : super();

  @override
  void paint(Canvas canvas, Size size) async{


    var paint2 = Paint();
    paint2.color = Color.fromRGBO(61, 61, 143, 1);
    paint2.style = PaintingStyle.fill;
    var path2 = Path();
    path2.moveTo(0,size.height*0.5);
    path2.lineTo(size.width,size.height*0.3);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    canvas.drawPath(path2, paint2);

    var paint = Paint();
    paint.color = Color.fromRGBO(255, 84, 84, 1);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height*0.5);
    path.lineTo(size.width,size.height*0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // TODO: Draw your path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}