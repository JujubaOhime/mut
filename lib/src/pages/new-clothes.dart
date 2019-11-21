import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class NewClothesPage extends StatefulWidget {
  static String tag = "newClothes-page";

  NewClothesPage();

  @override
  _NewClothesState createState() => _NewClothesState();
}

class _NewClothesState extends State<NewClothesPage> {
  String size, description, photo, title, type;
  String uid;
  Timestamp time;

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

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Clothes').document(title);
    Map<String, dynamic> clothes = {
      "photo": photo,
      "size": size,
      "type": type,
      "title": title,
      "uid": Authentication.usuarioLogado.uid,
      "description": description,
      "time": DateTime.now(),
    };

    ds.setData(clothes).whenComplete(() {
      print("roupa atualizada");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Layout.lightPink()),
        backgroundColor: Layout.white(),
        title: Text("Nova Roupa", style: TextStyle(color: Layout.lightPink())),
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
              maxLines: null,
              // controller: _taskNameController,
              onChanged: (String title) {
                getTitle(title);
              },
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(labelText: "Título", contentPadding:  new EdgeInsets.only(bottom:1), labelStyle: TextStyle(color: Layout.white(), fontWeight: FontWeight.bold, fontSize: 23, letterSpacing: 2, height: 0.85)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
            child: TextField(
              maxLines: null,
              //controller: _taskDetailsController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(labelText: "Descrição", contentPadding:  new EdgeInsets.only(bottom:1), labelStyle: TextStyle(color: Layout.white(), 
              fontWeight: FontWeight.bold, fontSize: 23, letterSpacing: 2, height: 0.85)),
              onChanged: (String description) {
                getDescription(description);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
            child: TextField(
              // controller: _taskDateController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(labelText: "Tipo", contentPadding:  new EdgeInsets.only(bottom:1), labelStyle: TextStyle(color: Layout.white(), fontWeight: FontWeight.bold, fontSize: 23, letterSpacing: 2, height: 0.85)),
              onChanged: (String type) {
                getType(type);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30, top: 10),
            child: TextField(
              // controller: _taskTimeController,
              style: TextStyle(color: Layout.white()),
              decoration: InputDecoration(labelText: "Tamaho", contentPadding:  new EdgeInsets.only(bottom:1), labelStyle: TextStyle(color: Layout.white(), fontWeight: FontWeight.bold, fontSize: 23, letterSpacing: 2, height: 0.85)),
              onChanged: (String size) {
                getSize(size);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: new RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          color: Layout.lightBlue(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Layout.white(), fontSize: 20),
                          )
                        )
                      ),
                      new Container(
                         margin: const EdgeInsets.only(left: 20),
                         child: new RaisedButton(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                           color: Layout.lightBlue(),
                          onPressed: () {
                            createData();
                          },
                          child: Text(
                            "Enviar",
                            style: TextStyle(color: Layout.white(), fontSize: 20),
                          )
                         )
                      )
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
