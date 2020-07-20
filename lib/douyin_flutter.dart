import 'dart:async';

import 'package:flutter/services.dart';

class DouyinFlutter {
  static MethodChannel _channel =  MethodChannel('douyin_flutter')
    ..setMethodCallHandler(_onMethodCall);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> register(String appid) async {
    var result = await _channel.invokeMethod('register', {'appid': appid});
    return result;
  }

  static Future<dynamic> isDouyinInstalled() async {
    var result = await _channel.invokeMethod('isDouyinInstalled');
    return result == 'true' ? true : false;
  }

  static Future<dynamic> getApiVersion() async {
    var result = await _channel.invokeMethod('getApiVersion');
    return result;
  }

  static Future<dynamic> openDouyin() async {
    var result = await _channel.invokeMethod('openDouyin');
    return result;
  }

  static Future<dynamic> login() async {
    // arguments['scope'] = arguments['scope'] ?? 'user_info';

    var result = await _channel.invokeMethod('login');
    return result;
  }

  static Future<dynamic> share(Map<String, dynamic> arguments) async {
    arguments['share_type'] = arguments['share_type'] ?? 'image';
    arguments['video_path'] = arguments['video_path'] ?? '';
    arguments['tag'] = arguments['tag'] ?? '';
    arguments['state'] = arguments['state'] ?? '';

    var result = await _channel.invokeMethod('share', arguments);

    return result;
  }

  static Future _onMethodCall(MethodCall methodCall) {
    if (methodCall.method == 'onAuthResut') {
      _streamController?.add(methodCall.arguments);
    }

    return Future.value();
  }

  static StreamController<String> _streamController;

  static Stream listenAuth() {
    _streamController = new StreamController<String>();
    return _streamController.stream;
  }

  static void unListenAuth() {
    _streamController?.close();
    _streamController=null;
  }
}
