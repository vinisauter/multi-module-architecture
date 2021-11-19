#import "AnalyticsFlutterPlugin.h"
#if __has_include(<analytics_flutter_plugin/analytics_flutter_plugin-Swift.h>)
#import <analytics_flutter_plugin/analytics_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "analytics_flutter_plugin-Swift.h"
#endif

@implementation AnalyticsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnalyticsFlutterPlugin registerWithRegistrar:registrar];
}
@end
