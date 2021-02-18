import 'package:flutter/services.dart';
import 'dart:ui' as ui;
class Images{
  load(asset) async{
      ByteData data = await rootBundle.load(asset);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      ui.FrameInfo fi = await codec.getNextFrame();
      return fi.image;
  }
}