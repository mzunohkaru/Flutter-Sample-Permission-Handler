import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_sample/logger.dart';

enum MicrophonePermissionStatus {
  granted,
  denied,
  restricted,
  limited,
  permanentlyDenied
}

class MicrophonePermissionsHandler {
  Future<bool> get isGranted async {
    final status = await Permission.microphone.status;
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

  Future<MicrophonePermissionStatus> request() async {
    final status = await Permission.microphone.request();
    logger.i('status: $status');
    switch (status) {
      case PermissionStatus.granted:
        logger.w('権限が許可されました！');
        return MicrophonePermissionStatus.granted;
      case PermissionStatus.denied:
        logger.w('権限が拒否されました...');
        return MicrophonePermissionStatus.denied;
      case PermissionStatus.limited:
        logger.w('権限が制限されています(iOS)');
        return MicrophonePermissionStatus.permanentlyDenied;
      case PermissionStatus.permanentlyDenied:
        logger.w('権限が永久に拒否されます(Android)');
        return MicrophonePermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        logger.w('権限が制限されています(iOS)');
        return MicrophonePermissionStatus.restricted;
      default:
        logger.w('権限が拒否されました...');
        return MicrophonePermissionStatus.denied;
    }
  }
}