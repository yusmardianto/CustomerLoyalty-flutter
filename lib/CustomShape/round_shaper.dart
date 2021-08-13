
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class RoundPainter extends CustomPainter {
  ui.Image assetImage;
  // RoundPainter(this.assetImage) : super();
  RoundPainter() : super();

  @override
  void paint(Canvas canvas, Size size) async{
    var paint3 = Paint();
    paint3.color = Color.fromRGBO(19, 19, 220, 0.8);
    paint3.style = PaintingStyle.fill;
    var path3 = Path();
    path3.moveTo(0, size.height*0.5);
    path3.lineTo(size.width, size.height*0.5);
    path3.lineTo(size.width, 0);
    path3.lineTo(0, 0);
    canvas.drawPath(path3, paint3);

    var paint4 = Paint();
    paint4.color = Color.fromRGBO(255, 84, 84, 1);
    paint4.style = PaintingStyle.fill;
    var path4 = Path();
    path4.moveTo(0, size.height*0.6);
    path4.lineTo(size.width, size.height*0.6);
    path4.lineTo(size.width, size.height);
    path4.lineTo(0,size.height);
    canvas.drawPath(path4, paint4);

    var paint = Paint();
    // if(assetImage!=null)canvas.drawImage(assetImage, Offset(-120,-180), paint);
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height*0.5);
    path.quadraticBezierTo(size.width*0.12, size.height*0.09,size.width,size.height*0.08);
    path.lineTo(size.width, size.height*0.5);
    path.lineTo(0, size.height*0.5);
    // TODO: Draw your path
    canvas.drawPath(path, paint);

    var paint2 = Paint();
    paint2.color = Colors.white;
    paint2.style = PaintingStyle.fill;
    var path2 = Path();
    path2.moveTo(size.width, size.height*0.6);
    path2.quadraticBezierTo(size.width*0.8, size.height*0.9,0,size.height*0.95);
    path2.lineTo(0, size.height*0.5);
    path2.lineTo(size.width, size.height*0.5);
    canvas.drawPath(path2, paint2);

    var paint5 = Paint();
    paint5.color = Color.fromRGBO(0, 71, 255, 0.69);
    paint5.style = PaintingStyle.fill;
    var path5 = Path();
    path5.moveTo(size.width, size.height*0.25);
    path5.quadraticBezierTo(size.width*0.7, size.height*0.35,size.width,size.height*0.45);
    path5.lineTo(size.width, size.height*0.3);
    canvas.drawPath(path5, paint5);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}