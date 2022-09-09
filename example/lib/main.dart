import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trial_ffi/generated/generated_bindings.dart';
import 'package:trial_ffi/trial_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textinput = TextEditingController();
  int result = 0;
  String stringresult = "";
  
  final DynamicLibrary trialFFILib = Platform.isAndroid
      ? DynamicLibrary.open('libtrial_ffi.so')
      : DynamicLibrary.process();

  // _tryNativ(int a, int b) {
  //   final int Function(int x, int y) trialFFI = trialFFILib
  //       .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('trial_ffi')
  //       .asFunction();
  // result = trialFFI(a,b);
  // return result;
  // }

  _tryEncrypt(Pointer<Utf8> inputs) {
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'encrypt')
        .asFunction();
    stringresult = trialFFI(inputs).toDartString();
    return stringresult;
  }

  _tryDecrypt(Pointer<Utf8> inputs) {
    final Pointer<Utf8> Function(Pointer<Utf8> text) trialFFI = trialFFILib
        .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>(
            'decrypt')
        .asFunction();

    stringresult = trialFFI(inputs).toDartString();
    return stringresult;
  }

  // String _platformVersion = 'Unknown';
  // final _trialFfiPlugin = TrialFfi();

  @override
  void initState() {
    super.initState();
    // _tryNativ(6, 10);

    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await _trialFfiPlugin.getPlatformVersion() ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            TextField(
              controller: textinput,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        print(textinput.text.toString().toNativeUtf8());
                        _tryEncrypt(textinput.text.toString().toNativeUtf8());
                      });
                    },
                    child: Text("Encrypt")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        print(stringresult.toNativeUtf8());
                        _tryDecrypt(stringresult.toNativeUtf8());
                      });
                    },
                    child: Text("Decrypt"))
              ],
            ),
            Center(
              child: Text('Running on: $stringresult\n', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),),
            ),
          ],
        ),
      ),
    );
  }
}
