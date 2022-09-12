import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'trial_ffi_platform_interface.dart';

class TrialFfi {
  Future<String?> getPlatformVersion() {
    return TrialFfiPlatform.instance.getPlatformVersion();
  }

  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();



 Future<String> tryEncrypt(String inputs) async {
    String stringresult = "";
    var inputUtf8 = inputs.toNativeUtf8();
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'encrypt')
        .asFunction();
    stringresult = trialFFI(inputUtf8).toDartString();
    return stringresult;
  }

  Future<String> tryDecrypt(String inputs) async {
    String stringresult = "";
    var inputUtf8 = inputs.toNativeUtf8();
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'decrypt')
        .asFunction();
    stringresult = trialFFI(inputUtf8).toDartString();
    return stringresult;
  }
  // final int Function(int x, int y) trialFFI = trialFFILib
  //     .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('trial_ffi')
  //     .asFunction();
}
