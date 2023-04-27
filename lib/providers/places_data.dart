import 'package:flutter/material.dart';

class PlacesData with ChangeNotifier {
  late double _latitude;
  double get latitude => _latitude;
  set latitude(double newLatitude) {
    _latitude = newLatitude;
    notifyListeners();
  }

  late double _longitude;
  double get longitude => _longitude;
  set longitude(double newLongitude) {
    _longitude = newLongitude;
    notifyListeners();
  }

  late String _location;
  String get location => _location;
  set location(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }

  late String _cause;
  String get cause => _cause;
  set cause(String newCause) {
    _cause = newCause;
    notifyListeners();
  }

  late String _url;
  String get url => _url;
  set url(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }

  late String _title;
  String get title => _title;
  set title(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}
