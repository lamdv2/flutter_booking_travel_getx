import 'dart:async';

import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  LatLng? _current;
  //duong
  // Map<PolylineId, Polyline> polylines = {};

  static const LatLng _pGooglePlex = LatLng(16.0321926, 108.2198714);
  static const LatLng _pApplePark =
      LatLng(16.05786987902542, 108.21159745424494);

  MapType currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    // getLocationUpdates().then(
    //   (_) => getPolylinePoints().then(
    //     (coordinates) => {
    //       generatePolyLineFromPoints(coordinates),
    //     },
    //   ),
    // );
    getPolyline('16.05786987902542', '108.21159745424494');
    loadImageMarker();
  }

  BitmapDescriptor? customIcon;

  void loadImageMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/custom_marker.png',
    );
  }

  void changeMapType() {
    setState(() {
      currentMapType = MapType.hybrid;
    });
  }

  void changeMapType01() {
    setState(() {
      currentMapType = MapType.satellite;
    });
  }

  void changeMapType02() {
    setState(() {
      currentMapType = MapType.terrain;
    });
  }

  void changeMapType03() {
    setState(() {
      currentMapType = MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController? controller;

    return Scaffold(
      body: Stack(
        children: [
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
              Marker(
                markerId: const MarkerId("_destinationLocation"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange),
                position: const LatLng(16.0311715, 108.2099274),
              ),
            },
            polylines: Set<Polyline>.of(polylines.values),
            mapType: currentMapType,
            // mapType: MapType.hybrid,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 36,
              right: 24,
            ),
            alignment: Alignment.topRight,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: ColorConstants.green,
                  onPressed: () {
                    changeMapType();
                  },
                  child: const Icon(
                    Icons.map,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  onPressed: () {
                    changeMapType01();
                  },
                  child: const Icon(
                    Icons.maps_ugc,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  backgroundColor: ColorConstants.secondColor,
                  onPressed: () {
                    changeMapType02();
                  },
                  child: const Icon(
                    Icons.maps_home_work,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  backgroundColor: ColorConstants.flights,
                  onPressed: () {
                    changeMapType03();
                  },
                  child: const Icon(
                    Icons.home,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void _addPolyLine() {
    setState(() {
      const id = PolylineId('poly');
      final polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 4,
      );
      polylines[id] = polyline;
    });
  }

  Future<void> getPolyline(String destLatitude, String destLongitude) async {
    Position? currentPosition;
    // currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.best,
    //     );
    try {
      final result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyB1h4sNHP1uFGKs59Y72uGiO6SLW7ZGNuk',
        // AIzaSyB-Lyksir7H6TAkkMk4PxNUkOz3KyuV9y4
        PointLatLng(16.0311715, 108.2099274),
        PointLatLng(double.parse(destLatitude), double.parse(destLongitude)),
        travelMode: TravelMode.transit,
      );

      polylineCoordinates.clear();

      if (result.points.isNotEmpty) {
        for (final point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      _addPolyLine();
    } catch (e) {
      print('Lỗi khi lấy tuyến đường: $e');
    }
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
    PolylineId id = const PolylineId("poly");
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
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
