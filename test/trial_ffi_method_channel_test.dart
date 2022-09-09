import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trial_ffi/trial_ffi_method_channel.dart';

void main() {
  MethodChannelTrialFfi platform = MethodChannelTrialFfi();
  const MethodChannel channel = MethodChannel('trial_ffi');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
