import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class VoucherPainter extends CustomPainter {
  // ui.Image assetImage;
  // VoucherPainter(this.assetImage) : super();
  String type;
  VoucherPainter(this.type) : super();

  @override
  void paint(Canvas canvas, Size size) async{
    var paint = Paint();
    if(type == "Voucher Code"){
      paint.color = Color.fromRGBO(38, 95, 126, 1);
    }
    else{

      // paint.color = Color.fromRGBO(255, 84, 84, 1);
      // paint.color = Color.fromRGBO(1, 1, 52, 1);
      paint.color = Color.fromRGBO(1, 1, 52, 1);
    }
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(20, 0);
    path.lineTo(size.width*0.75,0);
    path.lineTo(size.width*0.25, size.height);
    path.lineTo(20, size.height);
    path.lineTo(20, 0);
    path.addRRect(RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, 20, size.height), topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)));
    // TODO: Draw your path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}