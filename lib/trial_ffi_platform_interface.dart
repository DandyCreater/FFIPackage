import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'trial_ffi_method_channel.dart';

abstract class TrialFfiPlatform extends PlatformInterface {
  /// Constructs a TrialFfiPlatform.
  TrialFfiPlatform() : super(token: _token);

  static final Object _token = Object();

  static TrialFfiPlatform _instance = MethodChannelTrialFfi();

  /// The default instance of [TrialFfiPlatform] to use.
  ///
  /// Defaults to [MethodChannelTrialFfi].
  static TrialFfiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TrialFfiPlatform] when
  /// they register themselves.
  static set instance(TrialFfiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
