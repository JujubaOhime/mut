import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mut/src/pages/home-widget.dart';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class EditClothesPage extends StatefulWidget {
  static String tag = "editClothes-page";
  DocumentSnapshot doc;

  EditClothesPage({Key key, this.doc}) : super(key: key);

  @override
  _EditClothesPage createState() => _EditClothesPage(doc);
}

class _EditClothesPage extends State<EditClothesPage> {
  final _formKey = GlobalKey<FormState>();
  DocumentSnapshot doc;
  File sampleImage;
  String nomeImagem;
  bool uploading = false;

  _EditClothesPage(DocumentSnapshot d) {
    this.doc = d;
  }

  Future getImage() async {
    this.sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.nomeImagem = basename(sampleImage.path);
    setState(() {
      this.sampleImage = this.sampleImage;
      this.nomeImagem = this.nomeImagem;
    });
  }

  Future<dynamic> uploadPic(BuildContext context) async {
    this.uploading = true;
    String fileName = basename(this.sampleImage.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(sampleImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    return taskSnapshot.ref.getDownloadURL();
  }

  String size, description, photo, title, type, state, phone;
  String uid;
  Timestamp time;
  bool iniciado = false;

  getPhone(phone) {
    this.phone = phone;
  }

  getSize(size) {
    this.size = size;
  }

  getDescription(description) {
    this.description = description;
  }

  getPhoto(photo) {
    this.photo = photo;
  }

  getTitle(title) {
    this.title = title;
  }

  getType(type) {
    this.type = type;
  }

  getState(state) {
    this.state = state;
  }

  TextEditingController _csize = TextEditingController();
  TextEditingController _cdescription = TextEditingController();
  TextEditingController _cphoto = TextEditingController();
  TextEditingController _ctitle = TextEditingController();
  TextEditingController _ctype = TextEditingController();
  TextEditingController _cstate = TextEditingController();
  TextEditingController _cphone = TextEditingController();

  String urlFoto;

  _loadingCircle() {
    if (uploading) return CircularProgressIndicator();
    return Container();
  }

  /*createData() async {
    DocumentReference ds =
        Firestore.instance.collection('Clothes').document(title);
    String photo = "";
    uploading = true;
    if (sampleImage != null) photo = await uploadPic(context);
    Map<String, dynamic> clothes = {
      "photo": photo,
      "size": size,
      "type": type,
      "title": title,
      "uid": Authentication.usuarioLogado.uid,
      "description": description,
      "time": DateTime.now(),
      "state": "Rio de Janeiro",
    };

    ds.setData(clothes).whenComplete(() {
      print("roupa atualizada");
    });
  }*/

  @override
  Widget build(BuildContext context) {
    if (!iniciado) {
      _ctitle.text = doc['title'];
      _cstate.text = doc['state'];
      _csize.text = doc['size'];
      _cdescription.text = doc['description'];
      _ctype.text = doc['type'];
      _cphone.text = doc['phone'];
      urlFoto = doc['photo'];
      iniciado = true;
    }

    var location = new Location();
    String error;
    double latitude = 0;
    double longitude = 0;
    Map<String, double> myLocation;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Layout.lightPink()),
        backgroundColor: Layout.white(),
        title:
            Text("Editar Roupa", style: TextStyle(color: Layout.lightPink())),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              controller: _ctitle,
              maxLines: null,
              // controller: _taskNameController,
              onChanged: (String title) {
                getTitle(title);
              },
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(
                  labelText: "Título",
                  contentPadding: new EdgeInsets.only(bottom: 1),
                  labelStyle: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Layout.white(),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                      height: 0.85)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
            child: TextField(
              controller: _cdescription,
              maxLines: null,
              //controller: _taskDetailsController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(
                  labelText: "Descrição",
                  contentPadding: new EdgeInsets.only(bottom: 1),
                  labelStyle: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Layout.white(),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                      height: 0.85)),
              onChanged: (String description) {
                getDescription(description);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
            child: TextField(
              controller: _ctype,
              // controller: _taskDateController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(
                  labelText: "Tipo",
                  contentPadding: new EdgeInsets.only(bottom: 1),
                  labelStyle: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Layout.white(),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                      height: 0.85)),
              onChanged: (String type) {
                getType(type);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: TextField(
              controller: _csize,
              // controller: _taskTimeController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(
                  labelText: "Tamanho",
                  contentPadding: new EdgeInsets.only(bottom: 1),
                  labelStyle: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Layout.white(),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                      height: 0.85)),
              onChanged: (String size) {
                getSize(size);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: TextField(
              controller: _cphone,
              // controller: _taskTimeController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(
                  labelText: "Telefone",
                  contentPadding: new EdgeInsets.only(bottom: 1),
                  labelStyle: TextStyle(
                      fontFamily: 'BalooBhai',
                      color: Layout.white(),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                      height: 0.85)),
              onChanged: (String phone) {
                getPhone(phone);
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30, top: 10),
              child: this.sampleImage == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 10),
                            child: IconButton(
                              onPressed: () async {
                                getImage();
                              },
                              icon: Icon(
                                FontAwesomeIcons.upload,
                                color: Layout.white(),
                                size: 40,
                              ),
                            )),
                        Container(
                            //width: 20,
                            ),
                        Text(
                          "Selecione uma imagem",
                          style: TextStyle(color: Layout.white(), fontSize: 20),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          maxLines: null,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 10),
                            child: IconButton(
                              onPressed: () async {
                                getImage();
                              },
                              icon: Icon(
                                FontAwesomeIcons.upload,
                                color: Layout.white(),
                                size: 40,
                              ),
                            )),
                        new Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Text(basename(this.sampleImage.path),
                              style: TextStyle(
                                  color: Layout.white(), fontSize: 20),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: null),
                        ),
                      ],
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              color: Layout.lightBlue(),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    color: Layout.white(), fontSize: 20),
                              ))),
                      new Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: new RaisedButton(
                            child: Text(
                              "Enviar",
                              style: TextStyle(
                                  color: Layout.white(), fontSize: 20),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            color: Layout.lightBlue(),
                            onPressed: () async {
                              if (!this.uploading) {
                                myLocation = await location.getLocation();
                                latitude = myLocation['latitude'];
                                longitude = myLocation['longitude'];
                                String photo = "";
                                uploading:
                                true;
                                setState(() {});
                                if (sampleImage != null)
                                  photo = await uploadPic(context);
                                doc.reference.updateData({'photo': photo});
                                doc.reference.updateData({
                                  'time': DateTime.now(),
                                  'uid': Authentication.usuarioLogado.uid,
                                  'title': _ctitle.text,
                                  'state': _cstate.text,
                                  'size': _csize.text,
                                  'type': _ctype.text,
                                  'description': _cdescription.text,
                                  'photo': photo,
                                  'latitude': latitude,
                                  'longitude': longitude,
                                  'uname':
                                      Authentication.usuarioLogado.displayName,
                                  'phone': _cphone.text,
                                });
                                this.sampleImage = null;
                                this.nomeImagem = null;
                                /*while (Navigator.canPop(context)) {
                                    Navigator.of(context).pop();
                                  }
                                  */
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeWidget()));
                              }
                              /*
                                DocumentReference ds = Firestore.instance
                                    .collection('Clothes')
                                    .document(title);
                                String photo = "";
                                uploading = true;
                                if (sampleImage != null)
                                  photo = await uploadPic(context);
                                Map<String, dynamic> clothes = {
                                  "photo": photo,
                                  "size": size,
                                  "type": type,
                                  "title": title,
                                  "uid": Authentication.usuarioLogado.uid,
                                  "description": description,
                                  "time": DateTime.now(),
                                  "state": "Rio de Janeiro",
                                };
                                this.sampleImage = null;
                                this.nomeImagem = null;
                                /*while (Navigator.canPop(context)) {
                                  Navigator.of(context).pop();
                                }
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => HomeWidget()));*/*/
                            },
                          )),
                      /*
                              Container(
                                height: 30,
                                margin: EdgeInsets.only(top: 50),
                                child: Center(child: _loadingCircle()),
                              ),*/
                      // This button results in adding the contact to the database
                    ],
                  )),
            ],
          )
        ],
      ),
      backgroundColor: Layout.lightPink(),
    );
  }
}
