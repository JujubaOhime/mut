import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/login/login-widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mut/src/pages/edit-clothes.dart';
import 'package:mut/src/pages/new-clothes.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

enum ListAction {editar, deletar }

String title(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

class MyClothes extends StatelessWidget {
  static String tag = "myClothes-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _MyClothesState(),
    );
  }
}

class _MyClothesState extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
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
                            builder: (BuildContext context) => EditClothesPage(doc: doc,
                                )));
                        break;
                    }
                  },
                ),
              );
            }return Container(); 
          },
        );
      },
    );


    return Layout.getContent(context, content);
  }
}