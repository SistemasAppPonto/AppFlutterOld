import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  LatLng _currentLocationValor;
  static Location _location;
  StreamSubscription<LocationData> locationSubscription;

  static LocationService _instance;

  LocationService._internalConstructor();

  factory LocationService.getInstance() {
    _instance ??= LocationService._internalConstructor();
    _location ??= Location();
    return _instance;
  }

  Future<LatLng> ativarLocalizacaoAutomatica(GoogleMapController controllerMap) async {
    print("ativarLocalizacaoAutomatica");
    locationSubscription = _location.onLocationChanged().listen((LocationData currentLocation) {
      print("listen");
      print(currentLocation.latitude);
      print(currentLocation.longitude);

      _currentLocationValor = LatLng(currentLocation.latitude, currentLocation.longitude);

      print('_goToTheLake');
      final CameraPosition _kLake = CameraPosition(
        target: _currentLocationValor,
        zoom: 17.0,
      );
      controllerMap.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    });
  }

  Future<void> cancelarLocalizacaoAutomatica() {
    print("cancelarLocalizacaoAutomatica");
    locationSubscription.cancel().then((_) {
      print('cancelado');
    });
  }

  Location get location => _location;

  Future<LatLng> getLocation() async {
    print('getLocation');
//    PermissionStatus permission = await _location.hasPermission();
//    if(permission.)

    print(await _location.hasPermission());
    print(await _location.serviceEnabled());

    print('getLocation------');
    print(await _location.requestService());
    print('getLocation------2');
    print(await _location.requestPermission());
    print('getLocation------3');


    print('userLocation');
    var userLocation = await _location.getLocation();
    print('userLocation');
    _currentLocationValor = LatLng(userLocation.latitude, userLocation.longitude);
    print("_currentLocation");
    print(_currentLocationValor);
    print('_currentLocation');

    return _currentLocationValor;
  }

  LatLng get currentLocationValor => _currentLocationValor;
}
