import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _openResult = 'Unknown';
  String fileName;

  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {
    final dir = await getApplicationDocumentsDirectory();
    fileName = join(dir.path, 'test.txt');
    File file = new File(fileName);
    await file.writeAsString("This is a test");
    setState(() {
      _openResult = "ready";
    });
  }

  Future<String> openFile() async {
    var rs = await OpenFile.open(fileName);
    setState(() {
      _openResult = rs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('open result: $_openResult\n'),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: openFile,
          child: new Icon(Icons.open_in_new),
        ),
      ),
    );
  }
}
