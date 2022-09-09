import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DecryptFFI extends StatefulWidget {
  final String? input;
  const DecryptFFI({super.key, required this.input});

  @override
  State<DecryptFFI> createState() => _DecryptFFIState();
}

class _DecryptFFIState extends State<DecryptFFI> {
  String stringresult = "";
  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();

   _tryDecrypt(Pointer<Utf8> inputs) {
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'decrypt')
        .asFunction();

    stringresult = trialFFI(inputs).toDartString();
    return stringresult;
  }
  
  @override
  Widget build(BuildContext context) {
    return _tryDecrypt(widget.input!.toNativeUtf8());
  }
}