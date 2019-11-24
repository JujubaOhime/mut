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

class _ProfileClothesState extends StatelessWidget{

  DocumentSnapshot clothes;
 _ProfileClothesState({Key key, this.clothes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: Layout.font(), fontSize: 20.0, fontWeight: FontWeight.w400);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Layout.font(), fontSize: 25.0, fontWeight: FontWeight.w600);

    String id = clothes["uid"];
    String urlFoto = clothes['photo'];
    String title = clothes['title'];
    String description = clothes['description'];
    String type = clothes['type'];
    String size = clothes['size'];
    String uname = clothes['uname'];
    
    print(urlFoto);

    displayFoto() {
      if (clothes['photo'] != null) {
        return Container(
          height: 240,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                  image: NetworkImage(urlFoto), fit: BoxFit.contain)),
        );
      }
      return Container(
        height: 240,
        width: 120,
      );
    }

    displayString(String label) => Row(
      children: <Widget>[
        Expanded(
          child: Text(
            clothes[label],
            style: regularTextStyle,
          ),
        ),
      ],
    );


    var interesses = Firestore.instance.collection("Interests");

    final interestButton = RaisedButton(
      child: Text("Demonstrar Interesse"),
      onPressed: () {
        interesses.add({
          "uid": Authentication.usuarioLogado.uid,
          "uemail": Authentication.usuarioLogado.email,
          "uname": Authentication.usuarioLogado.displayName,
          "clothes": clothes.documentID
        });
      },
    );

    final _showInterest = StreamBuilder(
      stream: interesses.where("clothes", isEqualTo: clothes.documentID).snapshots(),
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
                    Text("Interessados"),
                    Row(
                      children: <Widget>[
                        Text(doc["uname"]),
                        RaisedButton(child: Text("Doar"))
                      ],
                    ),
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
                return Center(child: Text("Você ja demonstrou interesse"));
            });
      },
    );


    displayMultiLine(String label) => Flexible(
          fit: FlexFit.loose,
          child: Text(
            clothes[label],
            style: regularTextStyle,
            overflow: TextOverflow.clip,
            textDirection: TextDirection.ltr,
          ),
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
              padding: EdgeInsets.only(bottom: 20, top: 25, left:15, right: 15) ,
              child: Text(title)
            ),

            if (uname != null) displayString(uname), 
            //displayString("uid"),
            displayString("type"),
            displayString("size"),
            displayMultiLine("description"),
          ],
        ),
        width: MediaQuery.of(context).size.width - 150,
        padding: EdgeInsets.only(left: 15),
      );
    }





  final content = Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: ListBody(
          children: <Widget>[displayFoto(), coluna(),_showInterest],
        ),
      ),
    );
  return Layout.getContent(context, content);
  }
}