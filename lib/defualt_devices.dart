import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DefaultDevicesScreen extends StatefulWidget {
  const DefaultDevicesScreen({super.key});

  @override
  DefaultDevicesScreenState createState() => DefaultDevicesScreenState();
}

class DefaultDevicesScreenState extends State<DefaultDevicesScreen> {
  final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Devices'),
      ),
      body: FutureBuilder<List<BluetoothDevice?>>(
        future: _flutterBlue.connectedDevices,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (c, i) {
                BluetoothDevice device = snapshot.data![i]!;
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text(device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement disconnecting from the default device
                    },
                    child: const Text('Disconnect'),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text('No default device connected');
          }
        },
      ),
    );
  }
}
