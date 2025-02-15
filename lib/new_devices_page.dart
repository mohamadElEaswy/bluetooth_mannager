import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';

class BluetoothDevicesPage extends StatefulWidget {
  const BluetoothDevicesPage({super.key});

  @override
  BluetoothDevicesPageState createState() => BluetoothDevicesPageState();
}

class BluetoothDevicesPageState extends State<BluetoothDevicesPage> {
  final List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
    _scanForDevices();
  }

  Future<void> _scanForDevices() async {
    final flutterBlue = FlutterBluePlus.instance;

    // Start scanning for devices
    flutterBlue.startScan(timeout: const Duration(seconds: 5));

    // Listen for scan results
    final subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!_devicesList.contains(result.device)) {
          setState(() {
            _devicesList.add(result.device);
          });
        }
      }
    });

    // Stop scanning after 5 seconds
    await Future.delayed(const Duration(seconds: 5));
    flutterBlue.stopScan();

    // Cancel the subscription to prevent memory leaks
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          final device = _devicesList[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
            trailing: ElevatedButton(
              onPressed: () async {
                // Connect to the selected device
                await device.connect();

                // Navigate to the device details screen

                //  TODO device details screen

                // screen Navigator.push(
                //    context,
                //    MaterialPageRoute(
                //      builder: (context) => DeviceDetailsScreen(device: device),
                //    ),
                //  );
              },
              child: const Text('Connect'),
            ),
          );
        },
      ),
    );
  }
}
