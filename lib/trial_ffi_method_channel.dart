import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'trial_ffi_platform_interface.dart';

/// An implementation of [TrialFfiPlatform] that uses method channels.
class MethodChannelTrialFfi extends TrialFfiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('trial_ffi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
