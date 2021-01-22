import 'package:filmteambuilding_client/constants.dart';
import 'package:filmteambuilding_client/model/video_entry.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/button_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'model/video_entries.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/downloadlinks.dart';
import 'model/constants.dart';
import 'package:http/http.dart' as http;
import 'model/videolinks.dart';
import 'model/videolink.dart';

class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}

File _video;
TextEditingController titleController = TextEditingController();

final _firestore = FirebaseFirestore.instance;
bool uploading = false;

class _SourcePageState extends State<SourcePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
//Test prints

    print(videos.length);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Expanded(
              child: videos.length > 0
                  ? Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'Chosen Clips:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ListView.builder(
                              itemCount: videos.length,
                              itemBuilder: (BuildContext context, index) {
                                return Card(
                                  color: videos[index].uploaded == false
                                      ? Colors.white
                                      : Color(0xFFb7eda2),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.videocam,
                                        ),
                                        SizedBox(width: 15),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              videos[index].team,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              videos[index].videoTitle,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text('Click button below to add videos to be uploaded'),
            ),
            BasemenButton(
              icon: Icons.offline_share,
              onPressedFunc: () => pickGalleryVideo(context),
              buttonText:
                  videos.length > 0 ? 'Add more clips' : 'Choose video file',
              buttonColor: vtfOrange,
              textColor: Colors.white,
            ),
            videos.length > 0
                ? BasemenButton(
                    icon: uploading == false ? Icons.upload_file : null,
                    onPressedFunc: () => {
                      for (var i = 0; i < videos.length; i++)
                        {
                          if (videos[i].uploaded == false)
                            {
                              uploadFile(
                                  videos[i].videoUrl, videos[i].videoTitle, i)
                            }
                        }
                    },
                    buttonText: uploading == false
                        ? 'Upload ${videos.length.toString()} Clip(s)'
                        : 'Uploading',
                    buttonColor: uploading == false ? vtfOrange : Colors.grey,
                    textColor: Colors.white,
                  )
                : SizedBox(height: 0),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> pickGalleryVideo(BuildContext context) async {
    final String selectedTeam = ModalRoute.of(context).settings.arguments;
    final video = await ImagePicker().getVideo(source: ImageSource.gallery);
    print('VideoPicker done');
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        titleController.text = '';
        return AlertDialog(
          title: Text('Give your clip a title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  maxLength: 20,
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Clip title',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                videos.add(VideoEntry(
                    videoTitle: titleController.text,
                    videoUrl: video.path,
                    team: selectedTeam,
                    uploaded: false));
                Navigator.of(context).pop();
                print('AlertDialog size: ${videos.length}');
                setState(() {
                  _video = File(video.path);
                  print('Set State');
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadFile(String url, String title, int i) async {
    final File file = File(url);

    setState(() {
      uploading = true;
      print('SetState - sætter upload til true');
    });

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(videos[i].team + '/' + title + '.mov')
          .putFile(file);

      videolinks.add(Videolink(
          videotitle: videos[i].videoTitle, videolink: videos[i].team));

      //må slettes
      print('videolinks: ' + videolinks.length.toString());
      /*
      Downloadlinks downloadlinks = Downloadlinks(
        videos[i].videoTitle,
        videos[i].team,
      );
      await http.get(Constants.URL + downloadlinks.toParams());
      */
      print(title + ':' + videos[i].uploaded.toString());
      setState(() {
        videos[i].uploaded = true;
        print(title + ':' + videos[i].uploaded.toString());
      });
    } on firebase_core.FirebaseException catch (e) {
      print('noget gik galt');
      return;
      // e.g, e.code == 'canceled'
    }

    setState(() {
      uploading = false;
      print('SetState - sætter upload til false');
    });
  }
}
