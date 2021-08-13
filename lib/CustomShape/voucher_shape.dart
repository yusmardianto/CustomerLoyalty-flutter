import 'package:flutter/material.dart';

class VoucherPainter extends CustomPainter {
  String type;
  bool withRadius;
  VoucherPainter(this.type,{this.withRadius=true}) : super();

  @override
  void paint(Canvas canvas, Size size) async{
    var paint = Paint();
    if(type == "Voucher Code"){
      paint.color = Color.fromRGBO(38, 95, 126, 1);
    }
    else{
      paint.color = Color.fromRGBO(1, 1, 52, 1);
    }
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(20, 0);
    path.lineTo(size.width*0.75,0);
    path.lineTo(size.width*0.25, size.height);
    path.lineTo(20, size.height);
    path.lineTo(20, 0);
    path.addRRect(RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, 20, size.height), topLeft: Radius.circular(withRadius?20:0), bottomLeft: Radius.circular(withRadius?20:0)));
    // TODO: Draw your path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}