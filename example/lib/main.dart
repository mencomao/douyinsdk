import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:douyin_flutter/douyin_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _result = 'no result';
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
    var aaa = await DouyinFlutter.register('awsxdh3k1fiojgnu');
      // _result = result.toString();
    // }
    print(aaa);
    var result = await DouyinFlutter.login();
    _result = result.toString();
    print(_result);
  }

  void _share() async {
    var result = await DouyinFlutter.share({
      'share_type': 'image',
      'data': '',
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
