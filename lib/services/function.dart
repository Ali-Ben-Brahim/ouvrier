import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Check {
  Color check(double percent) {
    if (percent < 0.25) {
      return Colors.green;
    } else if (percent < 0.75) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  BitmapDescriptor check2(double percent) {
    if (percent < 25) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else if (percent < 75) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }
}