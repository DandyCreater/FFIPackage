#import "TrialFfiPlugin.h"
#if __has_include(<trial_ffi/trial_ffi-Swift.h>)
#import <trial_ffi/trial_ffi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "trial_ffi-Swift.h"
#endif

@implementation TrialFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTrialFfiPlugin registerWithRegistrar:registrar];
}
@end
