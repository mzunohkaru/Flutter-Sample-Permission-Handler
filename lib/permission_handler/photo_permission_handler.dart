import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/logger.dart';

enum PhotoPermissionStatus { granted, denied, permanentlyDenied, restricted }

class PhotoPermissionsHandler {
  Future<bool> get isGranted async {
    final status = await Permission.photos.status;
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

  Future<PhotoPermissionStatus> request() async {
    final status = await Permission.photos.request();
    logger.i('status: $status');
    switch (status) {
      case PermissionStatus.granted:
        logger.w('権限が許可されました！');
        return PhotoPermissionStatus.granted;
      case PermissionStatus.denied:
        logger.w('権限が拒否されました...');
        return PhotoPermissionStatus.denied;
      case PermissionStatus.limited:
        logger.w('権限が制限されています(iOS)');
        return PhotoPermissionStatus.permanentlyDenied;
      case PermissionStatus.permanentlyDenied:
        logger.w('権限が永久に拒否されます(Android)');
        return PhotoPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        logger.w('権限が制限されています(iOS)');
        return PhotoPermissionStatus.restricted;
      default:
        logger.w('権限が拒否されました...');
        return PhotoPermissionStatus.denied;
    }
  }
}
