import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../core/app_colors.dart';
import 'widgets/shimmer_loading.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  final MapController _controller = Get.find<MapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _updateMarker();
    // Listen to location changes
    ever(_controller.latitude, (_) => _updateMarker());
    ever(_controller.longitude, (_) => _updateMarker());
  }

  void _updateMarker() {
    if (_controller.latitude.value != 0.0 && _controller.longitude.value != 0.0) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(
              _controller.latitude.value,
              _controller.longitude.value,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: const InfoWindow(
              title: 'Current Location',
            ),
          ),
        );
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            _controller.latitude.value,
            _controller.longitude.value,
          ),
          15.0,
        ),
      );
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            // Full screen map
            _controller.isLoading.value
                ? const ShimmerFullScreenMap()
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _controller.latitude.value != 0.0 &&
                              _controller.longitude.value != 0.0
                          ? LatLng(
                              _controller.latitude.value,
                              _controller.longitude.value,
                            )
                          : const LatLng(51.5074, -0.1278), // Default to London
                      zoom: 15.0,
                    ),
                    markers: _markers,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      if (_controller.latitude.value != 0.0 &&
                          _controller.longitude.value != 0.0) {
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(
                            LatLng(
                              _controller.latitude.value,
                              _controller.longitude.value,
                            ),
                            15.0,
                          ),
                        );
                      }
                    },
                  ),

            // Back button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.softCardShadow,
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                ),
              ),
            ),

            // Location tracking button (bottom right)
            if (!_controller.isLoading.value)
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    _controller.toggleTracking();
                    if (_controller.isTracking.value) {
                      _updateMarker();
                    }
                  },
                  backgroundColor: Colors.white,
                  child: Obx(
                    () => Icon(
                      _controller.isTracking.value
                          ? Icons.location_searching
                          : Icons.location_disabled,
                      color: _controller.isTracking.value
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ),
              ),

            // Center on current location button
            if (!_controller.isLoading.value &&
                _controller.latitude.value != 0.0 &&
                _controller.longitude.value != 0.0)
              Positioned(
                right: 16,
                bottom: 80,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    _updateMarker();
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.my_location, color: Colors.blue),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

