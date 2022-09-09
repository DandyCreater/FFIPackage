import 'dart:ffi';
import 'dart:io';

import 'trial_ffi_platform_interface.dart';

class TrialFfi {
  Future<String?> getPlatformVersion() {
    return TrialFfiPlatform.instance.getPlatformVersion();
  }

  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();

  // final int Function(int x, int y) trialFFI = trialFFILib
  //     .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('trial_ffi')
  //     .asFunction();
}
