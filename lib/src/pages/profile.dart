import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class ProfilePage extends StatelessWidget {
  static String tag = "profile-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _ProfileState(),
    );
  }
}

class _ProfileState extends StatelessWidget {
  static String tag = "profile-page";
  @override
  Widget build(BuildContext context) {
    
    final content = StreamBuilder(
      stream: Firestore.instance
        .collection('User')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return const Text('Carregando.....');
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = snapshot.data.documents[index];
            if (doc['email'] == Authentication.usuarioLogado.email){
              return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 30, top: 30),
                    child: CircleAvatar(
                      maxRadius: 70,
                       backgroundImage:
                        NetworkImage(doc['photo']),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      doc['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, 
                      color: Layout.white(), letterSpacing: 1, fontWeight: 
                      FontWeight.bold),
                    )
                  ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Text(
                    doc['email'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, 
                      color: Layout.white())
                  )
                ),
                ],
              );
            }return Container();
          }
        
        );
      }
      
      
      
                
          
    );
    return Layout.getContent(context, content);
  }
}