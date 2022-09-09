import 'package:flutter_test/flutter_test.dart';
import 'package:trial_ffi/trial_ffi.dart';
import 'package:trial_ffi/trial_ffi_platform_interface.dart';
import 'package:trial_ffi/trial_ffi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTrialFfiPlatform
    with MockPlatformInterfaceMixin
    implements TrialFfiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TrialFfiPlatform initialPlatform = TrialFfiPlatform.instance;

  test('$MethodChannelTrialFfi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTrialFfi>());
  });

  test('getPlatformVersion', () async {
    TrialFfi trialFfiPlugin = TrialFfi();
    MockTrialFfiPlatform fakePlatform = MockTrialFfiPlatform();
    TrialFfiPlatform.instance = fakePlatform;

    expect(await trialFfiPlugin.getPlatformVersion(), '42');
  });
}
