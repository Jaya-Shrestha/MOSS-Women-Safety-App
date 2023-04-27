import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../providers/places_data.dart';

class RedZonesPage extends StatefulWidget {
  const RedZonesPage({super.key});

  @override
  State<RedZonesPage> createState() => _RedZonesPageState();
}

class _RedZonesPageState extends State<RedZonesPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0, 0);

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation, 13.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myDataModel = Provider.of<PlacesData>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentLocation,
                zoom: 13,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/jayashrestha243/clguir1fe003r01pgcudbbbrb/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiamF5YXNocmVzdGhhMjQzIiwiYSI6ImNsZ3VoY2o2eTE0bmgzbGw4OWp4b3F5cGQifQ.55Sz88S6E1lfQH99YLHo6Q',
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
                              Icons.stars_rounded,
                              size: 30,
                              color: Colors.blueAccent,
                            )),
                    Marker(
                        width: 80,
                        height: 80,
                        point:
                            LatLng(myDataModel.longitude, myDataModel.latitude),
                        anchorPos: AnchorPos.align(AnchorAlign.center),
                        builder: (cxt) => const Icon(
                              Icons.dangerous_outlined,
                              size: 40,
                              color: Colors.red,
                            )),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: MediaQuery.of(context).size.height * 0.365,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Nearest Red Zone',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      myDataModel.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Location:${myDataModel.location}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Cause:${myDataModel.cause}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'News Source: ${myDataModel.url}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),

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
      ),
    );
  }
}
