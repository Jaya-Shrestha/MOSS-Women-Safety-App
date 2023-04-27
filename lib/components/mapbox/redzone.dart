import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class BoomPage extends StatefulWidget {
  // final double latitude;
  // final double longitude;
  // final String location;
  // final String cause;
  // final String url;
  // final String title;
  final Future<List<dynamic>> future;

  const BoomPage({super.key, required this.future});

  // const BoomPage(this.latitude, this.longitude, this.location, this.cause,
  //     this.url, this.title,
  //     {super.key});
  // const BoomPage({super.key, required Future<List> future});
  @override
  State<BoomPage> createState() => _BoomPageState();
}

class _BoomPageState extends State<BoomPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(0, 0);

  void _getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation, 13.0);
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final myDataModel = Provider.of<PlacesData>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<List<dynamic>>(
                future: widget.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                center: _currentLocation,
                                zoom: 14,
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
                                      anchorPos:
                                          AnchorPos.align(AnchorAlign.center),
                                      builder: (cxt) => const Icon(
                                        Icons.circle,
                                        size: 50,
                                        color: Color.fromARGB(255, 188, 20, 79),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(255, 30, 29, 29),
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Nearest Red Zone',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data![5],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![2],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![3],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![4],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]);
                      },
                    );
                  }
                },
              )
              // Text(myDataModel.title),
              // Text(widget.cause),
              // Text(widget.title),
              // Text(widget.url),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   RedZonePage(widget.latitude, widget.longitude)));
              //     },
              //     child: const Text(
              //       "Show Location",
              //       style: TextStyle(fontSize: 16),
              //     ))

              )),
    );
  }
}
