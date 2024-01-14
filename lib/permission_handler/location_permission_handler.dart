import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/logger.dart';

enum LocationPermissionStatus { granted, denied, permanentlyDenied, restricted }

class LocationPermissionsHandler {
  Future<bool> get isGranted async {
    final status = await Permission.location.status;
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

  Future<bool> get isAlwaysGranted {
    return Permission.locationAlways.isGranted;
  }

  Future<LocationPermissionStatus> request() async {
    final status = await Permission.location.request();
    logger.i('status: $status');
    switch (status) {
      case PermissionStatus.granted:
        logger.w('権限が許可されました！');
        return LocationPermissionStatus.granted;
      case PermissionStatus.denied:
        logger.w('権限が拒否されました...');
        return LocationPermissionStatus.denied;
      case PermissionStatus.limited:
        logger.w('権限が制限されています(iOS)');
        return LocationPermissionStatus.permanentlyDenied;
      case PermissionStatus.permanentlyDenied:
        logger.w('権限が永久に拒否されます(Android)');
        return LocationPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        logger.w('権限が制限されています(iOS)');
        return LocationPermissionStatus.restricted;
      default:
        logger.w('権限が拒否されました...');
        return LocationPermissionStatus.denied;
    }
  }
}
