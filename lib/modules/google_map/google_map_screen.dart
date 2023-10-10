import 'dart:async';

import 'package:doan_clean_achitec/modules/google_map/map_key.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Location _locationController = Location();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  LatLng? _current = null;

  Map<PolylineId, Polyline> polylines = {};

  static const LatLng _pGooglePlex = LatLng(16.0321926, 108.2198714);
  static const LatLng _pApplePark =
      LatLng(16.05786987902542, 108.21159745424494);

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => getPolylinePoints().then(
        (coordinates) => {
          generatePolyLineFromPoints(coordinates),
        },
      ),
    );

    loadImageMarker();
  }

  BitmapDescriptor? customIcon;

  void loadImageMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/custom_marker.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController? controller;

    return Scaffold(
      body:
          // _current == null
          //     ? const Center(
          //         child: Text('Loading...'),
          //       )
          //     :
          GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            mapController.complete(controller)),
        initialCameraPosition: const CameraPosition(
          target: LatLng(16.0321926, 108.2198714),
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _current ?? const LatLng(16.0321926, 108.2298714),
            draggable: true,
            onDragEnd: (value) {},
          ),
          Marker(
            markerId: const MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: const LatLng(16.0321926, 108.2198714),
          ),
          Marker(
            markerId: const MarkerId("_destinationLocation"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: const LatLng(16.05786987902542, 108.21159745424494),
          ),
        },
        polylines: Set<Polyline>.of(polylines.values),
        // mapType: MapType.hybrid,
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   GOOGLE_MAPS_API_KEY,
    //   PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
    //   PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
    //   travelMode: TravelMode.driving,
    // );

    // if (result.points.isNotEmpty) {
    //   result.points.forEach((PointLatLng point) {
    //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    //   });
    // } else {
    //   Get.snackbar('Error', '${result.errorMessage}');
    // }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: ColorConstants.primaryButton,
      points: polylineCoordinates,
      width: 6,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _current =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_current!);
        });
      }
    });
  }
}
