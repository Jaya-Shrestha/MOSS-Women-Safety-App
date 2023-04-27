import 'package:latlong2/latlong.dart';

class AppConstants {
  static String urlTemplate =
      'https://api.mapbox.com/styles/v1/jayashrestha243/cld3xsx7j000301qp6v20xemn/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiamF5YXNocmVzdGhhMjQzIiwiYSI6ImNsZmNjaWZ1aDJyeGYzc28xZm5uY2VpYjYifQ.2MgMChCOVaN2u_oyExhwyg';

  static const String mapBoxAccessToken =
      'pk.eyJ1IjoiamF5YXNocmVzdGhhMjQzIiwiYSI6ImNsZ3VoY2o2eTE0bmgzbGw4OWp4b3F5cGQifQ.55Sz88S6E1lfQH99YLHo6Q';

  static const String mapBoxStyleId = 'mapbox.mapbox-streets-v8';

  static final myLocation = LatLng(27.7033, 85.3201);
}
