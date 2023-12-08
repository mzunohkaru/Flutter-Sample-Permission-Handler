import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/pages/gallery_page.dart';
import 'package:permission_handler_sample/pages/picture_page.dart';

Future<void> main() async {
  // main 関数内で非同期処理を呼び出すための設定
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // デバイスで使用可能なカメラのリストを取得
    final cameras = await availableCameras();
    // 利用可能なカメラのリストから特定のカメラを取得
    final firstCamera = cameras.first;

    runApp(MyApp(camera: firstCamera));
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  const MyHomePage({super.key, required this.camera});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final messanger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permission Handler"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
                function: () async {
                  PermissionStatus status = await Permission.camera.request();
                  if (status == PermissionStatus.granted) {
                    debugPrint("Permission Granted");

                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PicturePage(
                              camera: widget.camera,
                            )));
                  }
                  if (status == PermissionStatus.denied) {
                    debugPrint("Permission Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Camera"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.limited) {
                    debugPrint("Permission is Limited");
                  }
                  if (status == PermissionStatus.restricted) {
                    debugPrint("Permission is Restricted");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Allow us to use Camera"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.permanentlyDenied) {
                    debugPrint("Permission is Permanently Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot use Camera"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.camera),
                title: "Camera",
                color: Colors.red),
            _buildButton(
                function: () async {
                  PermissionStatus status = await Permission.storage.request();
                  if (status == PermissionStatus.granted) {
                    debugPrint("Permission Granted");

                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const GalleryPage()));
                  }
                  if (status == PermissionStatus.denied) {
                    debugPrint("Permission Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Storage"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.limited) {
                    debugPrint("Permission is Limited");
                  }
                  if (status == PermissionStatus.restricted) {
                    debugPrint("Permission is Restricted");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Allow us to use Storage"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.permanentlyDenied) {
                    debugPrint("Permission is Permanently Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot use Storage"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.image),
                title: "Image",
                color: Colors.teal),
            _buildButton(
                function: () async {
                  Map<Permission, PermissionStatus> multiplestatus =
                      await [Permission.camera, Permission.storage].request();
                  if (multiplestatus[Permission.camera]!.isGranted) {
                    debugPrint("Camera Permission is Granted");
                  }
                  if (multiplestatus[Permission.camera]!.isDenied) {
                    debugPrint("Permission Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Camera"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (multiplestatus[Permission.camera]!.isPermanentlyDenied) {
                    debugPrint("Permission is Permanently Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Camera"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }

                  if (multiplestatus[Permission.storage]!.isGranted) {
                    debugPrint("Photo Permission is Granted");
                  }
                  if (multiplestatus[Permission.storage]!.isDenied) {
                    debugPrint("Permission Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Photo"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (multiplestatus[Permission.storage]!.isPermanentlyDenied) {
                    debugPrint("Permission is Permanently Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Photo"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.folder_copy_rounded),
                title: "Multiple",
                color: Colors.blue),
            _buildButton(
                function: () async {
                  PermissionStatus status =
                      await Permission.location.request();
                  if (status == PermissionStatus.granted) {
                    debugPrint("Permission Granted");
                  }
                  if (status == PermissionStatus.denied) {
                    debugPrint("Permission Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot Access Location"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.limited) {
                    debugPrint("Permission is Limited");
                  }
                  if (status == PermissionStatus.restricted) {
                    debugPrint("Permission is Restricted");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Allow us to use Location"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                  if (status == PermissionStatus.permanentlyDenied) {
                    debugPrint("Permission is Permanently Denied");
                    messanger.showSnackBar(
                      SnackBar(
                        content: const Text("Cannot use Location"),
                        action: SnackBarAction(
                            label: "Open App Settings",
                            onPressed: () {
                              openAppSettings();
                            }),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.pin_drop),
                title: "Location",
                color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildButton(
      {required Function function,
      required Icon icon,
      required String title,
      required Color color}) {
    return ElevatedButton.icon(
      onPressed: () {
        function();
      },
      icon: icon,
      label: Text(title + " Permission"),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(250, 40),
        ),
        backgroundColor: MaterialStatePropertyAll(color),
      ),
    );
  }
}
