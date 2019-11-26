import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/login/login-widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mut/src/pages/new-clothes.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

import 'clothes-profile.dart';

enum ListAction { editar, deletar }

String title(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

class HomeWidget extends StatelessWidget {
  static String tag = "home-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _HomeWidgetState(),
    );
  }
}

class _HomeWidgetState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Distance distance = new Distance();


    _clothesCard(DocumentSnapshot doc, DocumentSnapshot doc2) => Container(
          height: 360,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            constraints: BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 3.0),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 20, top: 25, left: 15, right: 15),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => ProfileClothes(
                                    clothes: doc,
                                  )));
                        },
                        child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(8.0),
                            child: Image.network(doc["photo"],
                                fit: BoxFit.cover,
                                height: 200,
                                alignment: Alignment.center,
                                width: double.maxFinite)))),
                Center(
                    child: Text(title(doc['title'].toString()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'BalooBhai',
                            fontSize: 26,
                            color: Layout.white()))),
                Padding(
                  padding: EdgeInsets.only(
                    top: 6,
                  ),
                  child: Text(title(doc['type']), style: TextStyle(color: Layout.white(), fontSize: 17)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5, bottom: 0),
                    height: 0,
                    width: 25.0,
                    color: Layout.lightBlue()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Row(children: <Widget>[
                        Image.asset(
                          'assets/ic_distance2.png',
                          height: 20,
                        ),
                        Container(width: 8.0),

                        Text(
                          distance
                                  .as(
                                      LengthUnit.Kilometer,
                                      new LatLng(
                                          doc['latitude'], doc['longitude']),
                                      new LatLng(
                                          doc2['latitude'], doc2['longitude']))
                                  .toString() +
                              " km",
                          style: TextStyle(color: Layout.white(), fontSize: 14),
                        )
                      ]),
                    ),
                    Text(
                      "Tam " + doc["size"],
                      style: TextStyle(color: Layout.white(), fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
          decoration: new BoxDecoration(
            color: Layout.lightBlue(),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
        );


    _clothesRow(DocumentSnapshot doc, DocumentSnapshot doc2) => Container(
        margin: const EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
          bottom: 10,
        ),
        child: new Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            _clothesCard(doc, doc2),

          ],
        ));

    final content = StreamBuilder(
      stream: Firestore.instance
          .collection('Clothes')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = snapshot.data.documents[index];
            return StreamBuilder(
                stream: Firestore.instance
                    .collection("User")
                    .where("uid", isEqualTo: Authentication.usuarioLogado.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return const Center(child: CircularProgressIndicator());
                  return _clothesRow(doc, snapshot.data.documents[0]);
                }); 
          },
        );
      },
    );

    return Layout.getContent(context, content);
  }
}
