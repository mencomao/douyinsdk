package com.gami.douyin_flutter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.util.Log;
import android.os.Bundle;

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


public class ResultActivity extends Activity{
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    // setContentView(R.layout.activity_main);
    System.out.println("aaaaaa");
    DouYinOpenApi douyinOpenApi = DouYinOpenApiFactory.create(this);
    Authorization.Request request = new Authorization.Request();
    request.scope = "user_info"; // 用户授权时必选权限
    request.state = "ww";
    // request.callerLocalEntry = "com.gami.DouYinEntryActivity";
    // System.out.println("===>login2!"); // 用于保持请求和回调的状态，授权请求后原样带回给第三方。
    douyinOpenApi.authorize(request);

    // DouYinOpenApi hapi = DouYinOpenApiFactory.create(this);
    // startActivityForResult(getIntent(), 0x001);
    // hapi.handleIntent(getIntent(), this);
  }
  
  // @Override
  // public void onReq(BaseReq req) {

  // }

  // @Override
  // public void onResp(BaseResp resp) {
  //   // 授权成功可以获得authCode
  //   System.out.println("asdasdsadsadsadsadasdsad");
  // }

  // @Override
  // public void onErrorIntent(Intent intent) {
  //   // 错误数据
  //   // Toast.makeText(this, "intent出错啦", Toast.LENGTH_LONG).show();
  //   // finish();
  //   System.out.println("asdasdsadsadsadsadasdsad");
  // }

}