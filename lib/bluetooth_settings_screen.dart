import 'package:bluetooth_mannager/paired_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'defualt_devices.dart';
import 'new_devices_page.dart';

class BluetoothSettingsScreen extends StatefulWidget {
  @override
  _BluetoothSettingsScreenState createState() =>
      _BluetoothSettingsScreenState();
}

class _BluetoothSettingsScreenState extends State<BluetoothSettingsScreen> {
  BluetoothDevice? _defaultDevice;

  FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  @override
  void initState() {
    super.initState();
    _loadDefaultDevice();
  }

  Future<void> _loadDefaultDevice() async {
    // TODO: Implement loading the default Bluetooth device ID from shared preferences and set _defaultDevice accordingly
  }

  Future<void> _saveDefaultDeviceId(String deviceId) async {
    // TODO: Implement saving the default Bluetooth device ID to shared preferences
  }

  Future<void> _selectDefaultDevice(BluetoothDevice device) async {
    // TODO: Implement saving the selected Bluetooth device ID as the default to shared preferences and set _defaultDevice accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Default Device'),
            subtitle: _defaultDevice != null
                ? Text(_defaultDevice!.name ?? 'Unknown Device')
                : const Text('Not set'),
            trailing: ElevatedButton(
              child: const Text('Select'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefaultDevicesScreen()),
                );
                // TODO: Implement loading a list of connected Bluetooth devices using _flutterBlue.connectedDevices and show them in a modal bottom sheet.
                // When a device is selected, call _selectDefaultDevice to save the selected device as the default.
              },
            ),
          ),
          const Divider(),
           ListTile(
            title: const Text('Paired Devices'),
            subtitle: const Text('Tap a device to connect'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PairedDevicesPage()),
              );
            },
          ),
          const Divider(),
           ListTile(
            title: const Text('New Devices'),
            subtitle: const Text('Tap to scan for available devices'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BluetoothDevicesPage()),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<List<BluetoothDevice>>(
              stream: _flutterBlue.connectedDevices.asStream(),
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BluetoothDevice> devices = snapshot.data!;
                  return ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      BluetoothDevice device = devices[index];
                      return ListTile(
                        title: Text(device.name ?? 'Unknown Device'),
                        subtitle: Text(device.id.toString()),
                        onTap: () {
                          // TODO: Implement connecting to the selected Bluetooth device
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
