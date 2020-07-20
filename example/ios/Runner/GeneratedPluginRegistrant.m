//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<douyin_flutter/DouyinFlutterPlugin.h>)
#import <douyin_flutter/DouyinFlutterPlugin.h>
#else
@import douyin_flutter;
#endif

#if __has_include(<gallery_saver/GallerySaverPlugin.h>)
#import <gallery_saver/GallerySaverPlugin.h>
#else
@import gallery_saver;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [DouyinFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"DouyinFlutterPlugin"]];
  [GallerySaverPlugin registerWithRegistrar:[registry registrarForPlugin:@"GallerySaverPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
