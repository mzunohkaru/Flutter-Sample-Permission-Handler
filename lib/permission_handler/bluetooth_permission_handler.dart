import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/logger.dart';

enum BluetoothPermissionStatus {
  granted,
  denied,
  restricted,
  limited,
  permanentlyDenied
}

class BluetoothPermissionsHandler {
  Future<bool> get isGranted async {
    final status = await Permission.bluetooth.status;
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

  Future<BluetoothPermissionStatus> request() async {
    final status = await Permission.bluetooth.request();
    logger.i('status: $status');
    switch (status) {
      case PermissionStatus.granted:
        logger.w('権限が許可されました！');
        return BluetoothPermissionStatus.granted;
      case PermissionStatus.denied:
        logger.w('権限が拒否されました...');
        return BluetoothPermissionStatus.denied;
      case PermissionStatus.limited:
        logger.w('権限が制限されています(iOS)');
        return BluetoothPermissionStatus.permanentlyDenied;
      case PermissionStatus.permanentlyDenied:
        logger.w('権限が永久に拒否されます(Android)');
        return BluetoothPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        logger.w('権限が制限されています(iOS)');
        return BluetoothPermissionStatus.restricted;
      default:
        logger.w('権限が拒否されました...');
        return BluetoothPermissionStatus.denied;
    }
  }
}
