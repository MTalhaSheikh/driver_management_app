import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final LatLng pickupLocation;
  final LatLng dropOffLocation;

  const MapView({
    super.key,
    required this.pickupLocation,
    required this.dropOffLocation,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    setState(() {
      // Add pickup location marker
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup_location'),
          position: widget.pickupLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      );

      // Add drop-off location marker
      _markers.add(
        Marker(
          markerId: const MarkerId('dropoff_location'),
          position: widget.dropOffLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          infoWindow: const InfoWindow(title: 'Drop-off Location'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            (widget.pickupLocation.latitude + widget.dropOffLocation.latitude) / 2,
            (widget.pickupLocation.longitude + widget.dropOffLocation.longitude) / 2,
          ),
          zoom: 12.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _mapController?.animateCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: LatLng(
                  widget.pickupLocation.latitude < widget.dropOffLocation.latitude
                      ? widget.pickupLocation.latitude
                      : widget.dropOffLocation.latitude,
                  widget.pickupLocation.longitude < widget.dropOffLocation.longitude
                      ? widget.pickupLocation.longitude
                      : widget.dropOffLocation.longitude,
                ),
                northeast: LatLng(
                  widget.pickupLocation.latitude > widget.dropOffLocation.latitude
                      ? widget.pickupLocation.latitude
                      : widget.dropOffLocation.latitude,
                  widget.pickupLocation.longitude > widget.dropOffLocation.longitude
                      ? widget.pickupLocation.longitude
                      : widget.dropOffLocation.longitude,
                ),
              ),
              50.0, // Padding around the bounds
            ),
          );
        },
      ),
    );
  }
}
