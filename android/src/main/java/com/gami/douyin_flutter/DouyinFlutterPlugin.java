package com.gami.douyin_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.util.Log;

import com.bytedance.sdk.open.aweme.authorize.model.Authorization;
import com.bytedance.sdk.open.aweme.common.handler.IApiEventHandler;
import com.bytedance.sdk.open.aweme.base.ImageObject;
import com.bytedance.sdk.open.aweme.base.MediaContent;
import com.bytedance.sdk.open.aweme.common.model.BaseReq;
import com.bytedance.sdk.open.aweme.common.model.BaseResp;

import com.bytedance.sdk.open.aweme.base.VideoObject;
import com.bytedance.sdk.open.aweme.share.Share;
import com.bytedance.sdk.open.douyin.DouYinOpenApiFactory;
import com.bytedance.sdk.open.douyin.DouYinOpenConfig;
import com.bytedance.sdk.open.douyin.api.DouYinOpenApi;

// import com.gami.douyin_flutter.ResultActivity;

/** DouyinFlutterPlugin */
public class DouyinFlutterPlugin implements FlutterPlugin, MethodCallHandler, 
    PluginRegistry.ActivityResultListener, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private static Registrar registrar;
  private static Result _result;
  private Activity mActivity;
  private Context context;
  
  // private ResultActivity ra;
  // private DouyinFlutterPlugin(Activity activity) {
  //   // 存起来
  //   mActivity = activity;
  // }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "douyin_flutter");
    channel.setMethodCallHandler(this);
    this.context = flutterPluginBinding.getApplicationContext();
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    // DouyinFlutterPlugin.mActivity = registrar.activity();
    DouyinFlutterPlugin.registrar = registrar;
    final DouyinFlutterPlugin plugin = new DouyinFlutterPlugin();
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "douyin_flutter");
    channel.setMethodCallHandler(plugin);
    registrar.addActivityResultListener(plugin);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }

    else if (call.method.equals("register")) {
      String clientid = call.argument("appid").toString();
      DouYinOpenApiFactory.init(new DouYinOpenConfig(clientid));
      result.success(clientid);
    }

    else if (call.method.equals("login")) {
      // System.out.println("===>login!");
      DouYinOpenApi douyinOpenApi = DouYinOpenApiFactory.create(this.mActivity);
      Authorization.Request request = new Authorization.Request();
      request.scope = "user_info";                          // 用户授权时必选权限
      request.state = "ww";
      request.callerLocalEntry = "com.bytedance.sdk.share.demo.douyinapi.DouYinEntryActivity";
      // System.out.println("===>login2!");                        // 用于保持请求和回调的状态，授权请求后原样带回给第三方。
      douyinOpenApi.authorize(request);

      // result.success(r);
      // System.out.println("===>login3!");
      // Intent apiIntent = new Intent(this.mActivity,ResultActivity.class);
      // this.mActivity.startActivity(apiIntent);
      // douyinOpenApi.handleIntent(apiIntent, this);
      // System.out.println(this.mActivity.getClass());
      // this.mActivity.startActivityForResult(apiIntent, 0);
    }

    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    
    channel.setMethodCallHandler(null);
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    System.out.println("===>login22222!");
    if (requestCode == 0) {

      return true;
    }
    return true;
  }
  
  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    // TODO: your plugin is now attached to an Activity
    this.mActivity = activityPluginBinding.getActivity();
    
    activityPluginBinding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    // TODO: the Activity your plugin was attached to was destroyed to change
    // configuration.
    // This call will be followed by onReattachedToActivityForConfigChanges().
    this.mActivity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    // TODO: your plugin is now attached to a new Activity after a configuration
    // change.
  }

  @Override
  public void onDetachedFromActivity() {
    // TODO: your plugin is no longer associated with an Activity. Clean up
    // references.
  }

  // @Override
  // public void onReq(BaseReq req) {

  // }

  // @Override
  // public void onResp(BaseResp resp) {
  //   // 授权成功可以获得authCode
  //   // if (resp.getType() == CommonConstants.ModeType.SEND_AUTH_RESPONSE) {
  //   //   Authorization.Response response = (Authorization.Response) resp;
  //   //   if (resp.isSuccess()) {
  //   //     Toast.makeText(this, "授权成功，获得权限：" + response.grantedPermissions, Toast.LENGTH_LONG).show();

  //   //   } else {
  //   //     Toast.makeText(this, "授权失败" + response.grantedPermissions, Toast.LENGTH_LONG).show();
  //   //   }
  //   //   finish();
  //   // }
  // }

  // @Override
  // public void onErrorIntent(Intent intent) {
  //   // 错误数据
  //   // Toast.makeText(this, "intent出错啦", Toast.LENGTH_LONG).show();
  //   // finish();
  // }
  
}
