import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/map_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.find<MapController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.map_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Live Location (mock)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('Latitude: ${controller.latitude.value.toStringAsFixed(4)}'),
              Text(
                  'Longitude: ${controller.longitude.value.toStringAsFixed(4)}'),
              const SizedBox(height: 16),
              Text(
                controller.isTracking.value ? 'Tracking ON' : 'Tracking OFF',
                style: TextStyle(
                  color:
                      controller.isTracking.value ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  controller.toggleTracking();
                  if (controller.isTracking.value) {
                    controller.updateLocation(40.7128, -74.0060);
                  }
                },
                icon: Icon(controller.isTracking.value
                    ? Icons.location_disabled
                    : Icons.location_searching),
                label: Text(
                  controller.isTracking.value ? 'Stop Tracking' : 'Start Tracking',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

