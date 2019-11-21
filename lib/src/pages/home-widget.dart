import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/login/login-widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mut/src/pages/new-clothes.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

enum ListAction {editar, deletar }

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
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: Layout.white(),
        fontSize: 14.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 17.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600);

    _clothesImage(DocumentSnapshot doc) => Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      alignment: FractionalOffset.centerLeft,
      height: 130.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(doc["photo"]),
          fit: BoxFit.fill,
        ),
      ),
    );


    _clothesCard(DocumentSnapshot doc) => Container(
      height: 130.0,
      child: Container(
        margin: EdgeInsets.fromLTRB(90.0, 10.0, 16.0, 16.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 3.0),
            Row(
              children: <Widget>[
                Text(
                  title(doc['title'].toString()),
                  style: headerTextStyle,
                ),
                Container(
                  width: 10,
                ),
                Text( "Tam " +
                  doc["size"], 
                  style: subHeaderTextStyle,
                ),
              ],
            ),
            Text(doc['type'], style: subHeaderTextStyle),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,  
                width: 25.0,
                color: Layout.lightBlue()),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Image.asset(
                      'assets/ic_distance.png',
                      height: 15,
                    ),
                    Container(width: 8.0),
                    Text("95 km", style: regularTextStyle),
                  ]),
                )
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


    _more() => Container(
      margin: EdgeInsets.fromLTRB(0, 95, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap:(){print("click");},
            child: Icon(FontAwesomeIcons.ellipsisH),
          )
        ],
      ),
    );


    _clothesRow(DocumentSnapshot doc) => Container(
      height: 130.0,
      margin: const EdgeInsets.only(
        top: 25,
        left: 24,
        right: 24,
      ),
      child: new Stack(
        children: <Widget>[
          _clothesCard(doc),
          _clothesImage(doc),
          _more(),
        ],
      )
    );


    final content = StreamBuilder(
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
            if (doc['uid'] == Authentication.usuarioLogado.uid) {
              return ListTile(
                leading: Icon(Icons.pages),
                title: Text(doc['title']),
                subtitle: Text(doc['type']),
                trailing: PopupMenuButton<ListAction>(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<ListAction>>[
                      PopupMenuItem<ListAction>(
                        value: ListAction.deletar,
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.trashAlt),
                            Text("  Excluir")
                          ],
                        ),
                      ),
                      PopupMenuItem<ListAction>(
                        value: ListAction.editar,
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.pencilAlt),
                            Text("  Editar")
                          ],
                        ),
                      )
                    ];
                  },
                  onSelected: (ListAction result) {
                    switch (result) {
                      case ListAction.deletar:
                        doc.reference.delete();
                        break;
                      case ListAction.editar:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => NewClothesPage(
                                )));
                        break;
                    }
                  },
                ),
              );
            } 
            return _clothesRow(doc);
              // return ListTile(
              //   leading: Icon(Icons.pages),
              //   title: Text(doc['nome']),
              //   subtitle: Text(doc['raca']),
              // );
            
          },
        );
      },
    );


    return Layout.getContent(context, content);
  }

  //@override
  //_HomeWidgetState createState() => _HomeWidgetState();
}
