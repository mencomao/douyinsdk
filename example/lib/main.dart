import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:douyin_flutter/douyin_flutter.dart';

// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _result = 'no result';
  String path = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _result = 'no result';

    DouyinFlutter.listenAuth().listen((event) {
        if(event!=null){
          setState(() {
            _result='抖音登录成功,code=$event';
          });
        }else{
          setState(() {
            _result='抖音登录失败';
          });
        }
    });
  }

  @override
  void dispose() {
    super.dispose();
    DouyinFlutter.unListenAuth();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await DouyinFlutter.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // String code = await DouyinFlutter.login();
    // print(code);

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _login() async {
    // if (Platform.isAndroid) {
    var aaa = await DouyinFlutter.register('aw7s2ldh685lr0gz');
    // _result = result.toString();
    // }
    print(aaa);
    var result = await DouyinFlutter.login();
    _result = result.toString();
    print(_result);
  }

  void _share() async {
    print(path.toString());
    DouyinFlutter.register('aw7s2ldh685lr0gz');
    var result = await DouyinFlutter.share({
      'share_type': 'image',
      'video_path': path.toString(),
    });
    _result = result.toString();
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.system_update),
                title: Text('Running on: $_platformVersion\n'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Login via douyin'),
                onTap: () {
                  _login();
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Share to douyin'),
                onTap: () {
                  _share();
                },
              ),
              Center(
                child: Text('result: $_result'),
              )
            ],
          )),
    );
  }
}
