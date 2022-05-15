import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoneDepot extends StatefulWidget {
  const ZoneDepot({Key? key}) : super(key: key);

  @override
  State<ZoneDepot> createState() => _ZoneDepotState();
}

class _ZoneDepotState extends State<ZoneDepot> {
  LatLng bebLassal = const LatLng(36.813464052870216, 10.1689277263485);

  Set<Marker> markers = {};
  String googleAPiKey = "AIzaSyC0au9FbVLUYFvC5gRFnmXtiNYUgzM8Rwc";
  @override
  Widget build(BuildContext context) {
    CameraPosition BebLassal =
        CameraPosition(target: bebLassal, zoom: 14.151926040649414);
    final Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF196f3d),
            title: const Text("Zone de depot",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                ))),
        body: Column(children: [
          Container(
            width: 500,
            height: 400,
            padding: const EdgeInsets.all(20),
            child: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: markers,
              mapType: MapType.normal,
              initialCameraPosition: BebLassal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          ListTile(
              title: const Text("Bab Lassal"),

              trailing: IconButton(
                  icon: const Icon(
                    Icons.directions,
                    color: Colors.blue,
                    size: 38,
                  ),
                  onPressed: ()async {
                              if (await canLaunch("https://goo.gl/maps/FyU3ByvFTjPrVT2o7")) {
                                await launch("https://goo.gl/maps/FyU3ByvFTjPrVT2o7");
                              }
                            }, ),
              leading: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 38.0,
              ),
              onTap: () {}),
        ]));
  }

  @override
  void initState() {
    markers.add(
      Marker(
        markerId: const MarkerId("Zone1"),
        position: bebLassal, //position of marker
        infoWindow: const InfoWindow(title: "Beb Lassal", snippet: 'Depot A'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }
}
