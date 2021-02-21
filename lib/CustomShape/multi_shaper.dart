import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class MulltiPainter extends CustomPainter {
  ui.Image assetImage;
  // MulltiPainter(this.assetImage) : super();
  MulltiPainter() : super();

  @override
  void paint(Canvas canvas, Size size) async{

    var paint = Paint();
    paint.color = Color.fromRGBO(223, 76, 76, 1);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width*0.7, 0);
    path.quadraticBezierTo(size.width*0.6,size.height*0.15,size.width, size.height*0.16);
    path.lineTo(size.width, 0);
    path.lineTo(size.width*0.75, 0);
    canvas.drawPath(path, paint);

    var paint2 = Paint();
    paint2.color = Color.fromRGBO(243, 54, 54, 1);
    paint2.style = PaintingStyle.fill;
    var path2 = Path();
    path2.moveTo(0, size.height*0.22);
    path2.lineTo(size.width*0.54, size.height*0.4);
    path2.lineTo(size.width*0.3, size.height*0.67);
    path2.lineTo(0, size.height*0.67);
    canvas.drawPath(path2, paint2);

    var paint3 = Paint();
    paint3.color = Color.fromRGBO(39, 50, 155, 1);
    paint3.style = PaintingStyle.fill;
    var path3 = Path();
    path3.moveTo(size.width, size.height*0.52);
    path3.lineTo(size.width*0.7, size.height);
    path3.lineTo(size.width, size.height);
    canvas.drawPath(path3, paint3);

    var paint4 = Paint();
    paint4.color = Color.fromRGBO(122, 119, 119, 0.53);
    paint4.style = PaintingStyle.fill;
    var path4 = Path();
    path4.lineTo(size.width, 0);
    path4.lineTo(size.width, size.height);
    path4.lineTo(0, size.height);
    canvas.drawPath(path4, paint4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}