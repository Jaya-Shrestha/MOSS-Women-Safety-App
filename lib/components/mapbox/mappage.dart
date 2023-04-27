import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riderapp/components/mapbox/constants.dart';

// import 'package:riderapp/components/mapbox/boom.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0, 0);
  String _currentAddress = '';
  var responses;

  // List<dynamic> my_list = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // _getNearestPlaces();
  }

  // Future<void> _getData() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://redzone-production.up.railway.app/location/redzone/'));
  //     setState(() {
  //       _response = response.body;
  //     });
  //     print(_response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation, 13.0);
    });

    // Reverse geocoding
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final Placemark place = placemarks[0];
    setState(() {
      _currentAddress = "${place.name}, ${place.locality}, ${place.country}";
    });
  }

  Future<void> _getNearestPlaces() async {
    responses = await Dio().post(
        'https://redzone-production.up.railway.app/location/nearestredzone/',
        data: {
          "longitude": _currentLocation.longitude,
          "latitude": _currentLocation.latitude
        });
    print(responses.data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: _currentLocation,
                  zoom: 16,
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/jayashrestha243/clguir1fe003r01pgcudbbbrb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiamF5YXNocmVzdGhhMjQzIiwiYSI6ImNsZ3VoY2o2eTE0bmgzbGw4OWp4b3F5cGQifQ.55Sz88S6E1lfQH99YLHo6Q",
                      additionalOptions: const {
                        'accessToken':
                            'pk.eyJ1IjoiamF5YXNocmVzdGhhMjQzIiwiYSI6ImNsZ3VoY2o2eTE0bmgzbGw4OWp4b3F5cGQifQ.55Sz88S6E1lfQH99YLHo6Q',
                        'id': 'mapbox.mapbox-streets-v8',
                      }),
                  MarkerLayer(
                    markers: [
                      Marker(
                          width: 80,
                          height: 80,
                          point: _currentLocation,
                          anchorPos: AnchorPos.align(AnchorAlign.center),
                          builder: (cxt) => const Icon(
                                Icons.location_on,
                                size: 50,
                                color: Colors.blueAccent,
                              )),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "You are currently here \n $_currentAddress",
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     _getNearestPlaces();
            //     Timer.periodic(const Duration(seconds: 3), (Timer t) {
            //       // print(responses.data['latitude']);
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => BoomPage(
            //                   responses.data['latitude'],
            //                   responses.data['longitude'],
            //                   responses.data['location'],
            //                   responses.data['cause'],
            //                   responses.data['url'],
            //                   responses.data['title'],
            //                 )),
            //       );
            //     });
            //   },
            //   child: const Text("Red Zone Area"),
            // ),
          ],
        ),
      ),
    );
  }
}
