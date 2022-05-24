import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/models/post.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/services/uploadpost.dart';

class CompleteActivity extends StatefulWidget {
  final String activityID;
  CompleteActivity(this.activityID, this.activity, this.game, this.player);
  Game game;
  String activity;
  Player player;
  @override
  _CompleteActivityState createState() => _CompleteActivityState();
}

class _CompleteActivityState extends State<CompleteActivity> {
  bool imagePicked = false;
  File _image;
  var downloadURL;
  UploadPost uploadPost = UploadPost();
  TextEditingController caption = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Database _db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.game.name),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.activity,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      _image = File(
                                          await uploadPost.pickImageCamera());

                                      setState(() {
                                        if (_image != null) {
                                          imagePicked = true;
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text('Camera'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _image = File(
                                          await uploadPost.pickImageGallery());
                                      print('Image Taken');
                                      setState(() {
                                        if (_image != null) {
                                          imagePicked = true;
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text('Gallery'),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imagePicked
                              ? FileImage(_image)
                              : AssetImage('assets/image.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return "Please Enter a Caption";
                    }
                    return null;
                  },
                  controller: caption,
                  decoration: InputDecoration(
                    hintText: 'Caption',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formKey.currentState.save();
                          _formKey.currentState.validate();
                          SnackBar snackBar = SnackBar(
                              action: SnackBarAction(
                                label: 'Okay',
                                onPressed: () {},
                              ),
                              content: Text('Please Select a Image'));
                          if (imagePicked == false) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            if (caption.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                  action: SnackBarAction(
                                    label: 'Okay',
                                    onPressed: () {},
                                  ),
                                  content: Text('Please Enter Caption'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              uploadFunc();
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(
                          'POST',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadFunc() async {
    downloadURL = await uploadPost.uploadImageToFirebase(_image);
    // print(downloadURL);
    if (downloadURL != null) {
      Post post = new Post(widget.activityID, downloadURL, caption.text,
          widget.player.name, DateTime.now().toString(), widget.player.id);
      _db.postActivity(widget.game.id, post);
      // _db.updateScore(widget.game.id, widget.player.id);
    } else {
      SnackBar snackBar = SnackBar(
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
          content: Text('Your image is not valid'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
