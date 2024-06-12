import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dart_kzg_4844_util_method_channel.dart';

abstract class DartKzg4844UtilPlatform extends PlatformInterface {
  /// Constructs a DartKzg4844UtilPlatform.
  DartKzg4844UtilPlatform() : super(token: _token);

  static final Object _token = Object();

  static DartKzg4844UtilPlatform _instance = MethodChannelDartKzg4844Util();

  /// The default instance of [DartKzg4844UtilPlatform] to use.
  ///
  /// Defaults to [MethodChannelDartKzg4844Util].
  static DartKzg4844UtilPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DartKzg4844UtilPlatform] when
  /// they register themselves.
  static set instance(DartKzg4844UtilPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
