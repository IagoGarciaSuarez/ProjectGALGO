//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_nfc_kit/FlutterNfcKitPlugin.h>)
#import <flutter_nfc_kit/FlutterNfcKitPlugin.h>
#else
@import flutter_nfc_kit;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterNfcKitPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterNfcKitPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
