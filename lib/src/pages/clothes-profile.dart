import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

import 'home-widget.dart';

class ProfileClothes extends StatelessWidget {
  DocumentSnapshot clothes;
  ProfileClothes({Key key, this.clothes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _ProfileClothesState(
        clothes: clothes,
      ),
    );
  }
}

class _ProfileClothesState extends StatelessWidget {
  String toTitle(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

  DocumentSnapshot clothes;
  _ProfileClothesState({Key key, this.clothes}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String id = clothes["uid"];
    String urlFoto = clothes['photo'];
    String title = clothes['title'];
    String description = clothes['description'];
    String type = clothes['type'];
    String size = clothes['size'];
    String uname = clothes['uname'];
    String phone = clothes['phone'];

    print(urlFoto);

    displayFoto() {
      if (clothes['photo'] != null) {
        return Container(
          height: 300,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                  image: NetworkImage(urlFoto), fit: BoxFit.cover)),
        );
      }
      return Container(
        height: 240,
        width: 120,
      );
    }

    var interesses = Firestore.instance.collection("Interests");

    final interestButton = GestureDetector(
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          'assets/like.png',
          width: 40,
        ),
      ),
      onTap: () {
        interesses.add({
          "uid": Authentication.usuarioLogado.uid,
          "uemail": Authentication.usuarioLogado.email,
          "uname": Authentication.usuarioLogado.displayName,
          "clothes": clothes.documentID,
        });
      },
    );

    final desinterestButton = GestureDetector(
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          'assets/like.png',
          width: 40,
        ),
      ),
      onTap: () {
        interesses.add({
          "uid": Authentication.usuarioLogado.uid,
          "uemail": Authentication.usuarioLogado.email,
          "uname": Authentication.usuarioLogado.displayName,
          "clothes": clothes.documentID
        });
      },
    );

    final _showInterest = StreamBuilder(
      stream: interesses
          .where("clothes", isEqualTo: clothes.documentID)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());
        if (id == Authentication.usuarioLogado.uid) {
          if (snapshot.data.documents.length == 0) {
            return const Center(
              child: Text(
                "Você não tem ninguem interessado",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    //Text("Interessados"),
                    /*
                    Row(
                      children: <Widget>[
                        Text(doc["uname"]),
                        
                      ],
                    ),*/
                  ],
                ),
              );
            },
          );
        }
        return StreamBuilder(
            stream: interesses
                .where("clothes", isEqualTo: clothes.documentID)
                .where("uid", isEqualTo: Authentication.usuarioLogado.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());
              if (snapshot.data.documents.length == 0)
                return interestButton;
              else
                return Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/liked.png',
                        width: 40,
                      ),
                    ));
            });
      },
    );


    coluna() {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 15,
            ),
            Padding(
                padding:
                    EdgeInsets.only(bottom: 0, top: 10, left: 15, right: 15),
                child: Text(toTitle(title),
                    style: TextStyle(
                        color: Layout.white(),
                        fontSize: 40,
                        fontFamily: 'BalooBhai'))),
            Row(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(bottom: 0, top: 0, left: 15, right: 15),
                  child: Text(
                    toTitle(type),
                    style: TextStyle(color: Layout.white(), fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(bottom: 0, top: 15, left: 15, right: 15),
                  child: Text(
                    "Tamanho " + size,
                    style: TextStyle(color: Layout.white(), fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(bottom: 15, top: 15, left: 15, right: 15),
                  child: Row(children: <Widget>[
                    Image.asset(
                      'assets/telephone.png',
                      height: 30,
                    ),
                    Container(
                      width: 15,
                    ),

                    Text(phone,
                        style: TextStyle(color: Layout.white(), fontSize: 20))
                  ]),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(bottom: 0, top: 0, left: 15, right: 0),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Descrição: " + description,
                          maxLines: null,
                          style: TextStyle(color: Layout.white(), fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width - 150,
      );
    }

    final content = Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: ListBody(
          children: <Widget>[
            displayFoto(), 
            coluna(), 
            _showInterest],
        ),
      ),
    );
    return Layout.getContent(context, content);
  }
}
