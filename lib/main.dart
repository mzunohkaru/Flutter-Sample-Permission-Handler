import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler_sample/permission_handler/bluetooth_permission_handler.dart';
import 'package:permission_handler_sample/permission_handler/camera_permission_handler.dart';
import 'package:permission_handler_sample/permission_handler/location_permission_handler.dart';
import 'package:permission_handler_sample/permission_handler/microphone_permission_handler.dart';
import 'package:permission_handler_sample/permission_handler/photo_permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // リクエストを出す処理
      // LocationPermissionsHandler().request();
      return null;
    }, []);

    final locationPermissionRequest = useCallback(() {
      LocationPermissionsHandler().request();
    }, []);

    final microphonePermissionRequest = useCallback(() {
      MicrophonePermissionsHandler().request();
    }, []);

    final cameraPermissionRequest = useCallback(() {
      CameraPermissionsHandler().request();
    }, []);

    final photoPermissionRequest = useCallback(() {
      PhotoPermissionsHandler().request();
    }, []);

    final bluetoothPermissionRequest = useCallback(() {
      BluetoothPermissionsHandler().request();
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text("Permission Handler")),
      body: ListView(
        children: [
          buildCard(title: "Location", onPressed: locationPermissionRequest),
          buildCard(
              title: "Microphone", onPressed: microphonePermissionRequest),
          buildCard(title: "Camera", onPressed: cameraPermissionRequest),
          buildCard(title: "Photo", onPressed: photoPermissionRequest),
          buildCard(title: "Bluetooth", onPressed: bluetoothPermissionRequest),
        ],
      ),
    );
  }

  ListTile buildCard({required String title, required VoidCallback onPressed}) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
          onPressed: onPressed, icon: const Icon(Icons.download_for_offline)),
    );
  }
}
