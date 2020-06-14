#import "DouyinFlutterPlugin.h"

@implementation DouyinFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"douyin_flutter"
            binaryMessenger:[registrar messenger]];
  DouyinFlutterPlugin* instance = [[DouyinFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary *arguments = [call arguments];
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  
  // Register app 
  else if ([@"register" isEqualToString:call.method]) {
    [[DouyinOpenSDKApplicationDelegate sharedInstance] registerAppId:arguments[@"appid"]];
    result(nil);
  }

  else if ([@"isDouyinInstalled" isEqualToString:call.method]) {
    result([NSString stringWithFormat:@"%@", true ? @"true" : @"false"]);
  }

  else if ([@"getApiVersion" isEqualToString:call.method]) {
    NSString *apiVersion = [NSString stringWithFormat:@"Current Douyin SDK Version : V%@",[DouyinOpenSDKApplicationDelegate sharedInstance].currentVersion];

    result([NSString stringWithFormat:@"%@", apiVersion]);
  }

  else if ([@"openDouyin" isEqualToString:call.method]) {
    result(nil);
  }
  // Login via douyin
  else if ([@"login" isEqualToString:call.method]) {
    // NSString* scope= arguments[@"user_info"];
    // NSString* state= arguments[@"state"];
    
    DouyinOpenSDKAuthRequest *req = [[DouyinOpenSDKAuthRequest alloc] init];
    req.permissions = [NSOrderedSet orderedSetWithObject:@"user_info"];
    UIViewController *rootViewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
    [req sendAuthRequestViewController:rootViewController completeBlock:^(BDOpenPlatformAuthResponse * _Nonnull resp) {
        NSString *alertString = nil;
        if (resp.errCode == 0) {
            alertString = [NSString stringWithFormat:@"Author Success Code : %@, permission : %@",resp.code, resp.grantedPermissions];
        } else{
            alertString = [NSString stringWithFormat:@"Author failed code : %@, msg : %@",@(resp.errCode), resp.errString];
        }
        result(alertString);
    }];
  }
  // douyin share 只能分享图片或者视频
  else if ([@"share" isEqualToString:call.method]) {
    NSString* share_type= arguments[@"share_type"];
    NSArray *data = [NSArray array];
    
    NSLog(@"This here");
    DouyinOpenSDKShareRequest *req = [[DouyinOpenSDKShareRequest alloc] init];
    if ([@"image" isEqualToString:share_type]) {
      req.mediaType = BDOpenPlatformShareMediaTypeImage;
    } else {
      req.mediaType = BDOpenPlatformShareMediaTypeVideo;
    }
    req.localIdentifiers = nil;
    req.hashtag = @"变脸挑战";
    req.state = @"a47e57c6c559acb88a9569da66ee5f65e0f779c9";
    NSLog(@"This here1");
    [req sendShareRequestWithCompleteBlock:^(BDOpenPlatformShareResponse * _Nonnull respond) {
        NSString *alertString = nil;
        if (respond.isSucceed) {
            //  Share Succeed
            alertString = [NSString stringWithFormat:@"Share Success"];
        } else{
            //  Share failed
            alertString = [NSString stringWithFormat:@"Share failed"];
        }
        NSLog(@"This here2");
        result(alertString);
    }];

    
  }

  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
