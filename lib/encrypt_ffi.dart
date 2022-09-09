import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EncryptFFI extends StatefulWidget {
  final String? input;
  const EncryptFFI({super.key, required this.input});

  @override
  State<EncryptFFI> createState() => _EncryptFFIState();
}

class _EncryptFFIState extends State<EncryptFFI> {
  String stringresult = "";
  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();

  tryEncrypt(Pointer<Utf8> inputs) {
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'encrypt')
        .asFunction();
    stringresult = trialFFI(inputs).toDartString();
    print(stringresult);
    return stringresult;
  }
  
  @override
  Widget build(BuildContext context) {
    return tryEncrypt(widget.input!.toNativeUtf8());
  }
}