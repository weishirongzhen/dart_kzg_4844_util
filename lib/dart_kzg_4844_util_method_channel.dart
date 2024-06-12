import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dart_kzg_4844_util_platform_interface.dart';

/// An implementation of [DartKzg4844UtilPlatform] that uses method channels.
class MethodChannelDartKzg4844Util extends DartKzg4844UtilPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dart_kzg_4844_util');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
