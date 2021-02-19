import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class WavePainter extends CustomPainter {
  ui.Image assetImage;
  // WavePainter(this.assetImage) : super();
  WavePainter() : super();

  @override
  void paint(Canvas canvas, Size size) async{
    var paint = Paint();
    paint.color = Color.fromRGBO(61, 61, 143, 1);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height*0.45);
    path.lineTo(size.width, size.height*0.45);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);

    var paint2 = Paint();
    paint2.color = Color.fromRGBO(255, 84,84, 1);
    paint2.style = PaintingStyle.fill;
    var path2 = Path();
    path2.moveTo(0, size.height*0.2);
    path2.lineTo(size.width*0.2, size.height*0.3);
    path2.lineTo(0, size.height*0.41);
    path2.lineTo(0, size.height*0.3);
    canvas.drawPath(path2, paint2);

    var paint3 = Paint();
    paint3.color = Color.fromRGBO(255, 84,84, 1);
    paint3.style = PaintingStyle.fill;
    var path3 = Path();
    path3.moveTo(size.width*0.9, size.height*0.04);
    path3.lineTo(size.width*0.8, size.height*0.09);
    path3.lineTo(size.width*0.75, size.height*0.14);
    path3.lineTo(size.width*0.875, size.height*0.09);
    path3.lineTo(size.width, size.height*0.16);
    path3.lineTo(size.width, size.height*0.09);
    path3.lineTo(size.width*0.9, size.height*0.04);
    canvas.drawPath(path3, paint3);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}