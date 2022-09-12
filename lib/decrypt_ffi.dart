import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DecryptFFI{
  String stringresult = "";
  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();


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

  // tryEncrypt(Pointer<Utf8> inputs) {
  //   final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
  //       .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
  //           'decrypt')
  //       .asFunction();
  //   stringresult = trialFFI(inputs).toDartString();
  //   print(stringresult);
  //   return stringresult;
  // }
}


// class DecryptFFI extends StatefulWidget {
//   final String? input;
//   const DecryptFFI({super.key, required this.input});

//   @override
//   State<DecryptFFI> createState() => _DecryptFFIState();
// }

// class _DecryptFFIState extends State<DecryptFFI> {
//   String stringresult = "";
//   final DynamicLibrary trialFFILib = Platform.isAndroid
//       ? DynamicLibrary.open('libtrial_ffi.so')
//       : DynamicLibrary.process();

//    tryDecrypt(Pointer<Utf8> inputs) {
//     final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
//         .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
//             'decrypt')
//         .asFunction();

//     stringresult = trialFFI(inputs).toDartString();
//     print(stringresult);
//     return stringresult;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return tryDecrypt(widget.input!.toNativeUtf8());
//   }
// }