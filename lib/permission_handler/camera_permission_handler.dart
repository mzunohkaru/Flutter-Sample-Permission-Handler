import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/logger.dart';

enum CameraPermissionStatus {
  granted,
  denied,
  restricted,
  limited,
  permanentlyDenied
}

class CameraPermissionsHandler {
  Future<bool> get isGranted async {
    final status = await Permission.camera.status;
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        return false;
      default:
        return false;
    }
  }

  Future<CameraPermissionStatus> request() async {
    final status = await Permission.camera.request();
    logger.i('status: $status');
    switch (status) {
      case PermissionStatus.granted:
        logger.w('権限が許可されました！');
        return CameraPermissionStatus.granted;
      case PermissionStatus.denied:
        logger.w('権限が拒否されました...');
        return CameraPermissionStatus.denied;
      case PermissionStatus.limited:
        logger.w('権限が制限されています(iOS)');
        return CameraPermissionStatus.permanentlyDenied;
      case PermissionStatus.permanentlyDenied:
        logger.w('権限が永久に拒否されます(Android)');
        return CameraPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        logger.w('権限が制限されています(iOS)');
        return CameraPermissionStatus.restricted;
      default:
        logger.w('権限が拒否されました...');
        return CameraPermissionStatus.denied;
    }
  }
}
