import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String title;

  Uploader({@required this.file, @required this.title});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  @override
  Widget build(BuildContext context) {
    final firebase_storage.FirebaseStorage _storage =
        firebase_storage.FirebaseStorage.instanceFor(
            bucket: 'gs://filmteambuilding-c2a8c.appspot.com');

    return Container();
  }
}
