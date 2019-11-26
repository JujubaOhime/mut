import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/pages/clothes-profile.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class ProfilePage extends StatelessWidget {
  static String tag = "profile-page";

  DocumentSnapshot user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _ProfileState(
        user: user,
      ),
    );
  }
}

class _ProfileState extends StatelessWidget {
  String title(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
  final Distance distance = new Distance();
  static String tag = "profile-page";
  DocumentSnapshot user;
  _ProfileState({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _clothesCard(DocumentSnapshot doc) => Container(
          height: 340,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            constraints: BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 3.0),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: 10, top: 25, left: 15, right: 15),
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
                    top: 0,
                  ),
                  child: Text(title(doc['type']),
                      style: TextStyle(color: Layout.white(), fontSize: 14)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 0, bottom: 0),
                    height: 5,
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
                                          user['latitude'], user['longitude']))
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

    _clothesRow(DocumentSnapshot doc) => Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
          bottom: 0,
        ),
        child: new Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            _clothesCard(doc),
          ],
        ));

    final content = Column(

      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.only(bottom: 10, top: 30, left: 20, right: 20),
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(100.0),
                child: Image.network(
                  user['photo'],
                  fit: BoxFit.fitWidth,
                  height: 150,
                ))),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            user['name'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Layout.white(),
                fontSize: 32,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(user['email'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Layout.white()))),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(user['state'] + " - " + user['city'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Layout.white()))),
        Expanded(
          child: StreamBuilder(
          stream: Firestore.instance
              .collection('Clothes')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text('Carregando.....');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot doc = snapshot.data.documents[index];
                if (doc['uid'] == user['uid']) {
                  return _clothesRow(doc);
                }
                return Container();
              }
              );
          },
        ),
        ),
        
      ],
    );
    return Layout.getContent(context, content);
  }
}
