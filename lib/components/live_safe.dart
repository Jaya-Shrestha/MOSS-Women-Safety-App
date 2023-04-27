import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/components/home_widgets/bus_stations.dart';
import 'package:riderapp/components/home_widgets/hospital.dart';
import 'package:riderapp/components/home_widgets/pharmacies.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_widgets/police_station.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri url = Uri.parse(googleUrl);
    try {
      await launchUrl(url);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went Wrong! Call for Emergency!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: const [
            PoliceStationCard(
              onMapFunction: openMap,
            ),
            HospitalCard(
              onMapFunction: openMap,
            ),
            PharmaciesCard(
              onMapFunction: openMap,
            ),
            BusStationCard(
              onMapFunction: openMap,
            ),
          ],
        ),
      ),
    );
  }
}
