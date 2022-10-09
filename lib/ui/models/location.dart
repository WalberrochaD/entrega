import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  Location() {
    getPosition();
  }

  getPosition() async {
    try {
      Position position = await _positionCurrent();
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<double> calcuteDistance(
      {required double latStore, required double longStore}) async {
    await getPosition();
    final double startLatitude = lat;
    final double startLongitude = long;
    final double endLatitude = latStore;
    final double endLongitude = latStore;

    final double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    return distance / 100000;
  }

  Future<Position> _positionCurrent() async {
    LocationPermission permission;
    bool activated = await Geolocator.isLocationServiceEnabled();
    if (!activated) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
