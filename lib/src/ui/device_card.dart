import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.device, this.onTap});
  final BluetoothDevice device;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text(device.id.toString()),
      onTap: onTap,
    );
  }
}
