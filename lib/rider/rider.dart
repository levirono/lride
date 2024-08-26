import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:myride/utilities/map.dart';

class RiderDashboard extends StatelessWidget {
  const RiderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body:
      
      Column(
        children: [
          const Expanded(
            child: MapView(
              initialPosition: LatLng(0, 34),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement go online/offline functionality
                  },
                  child: const Text('Go Online'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement view profile functionality
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('View Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

