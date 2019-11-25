import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class ProfilePage extends StatelessWidget {
  static String tag = "profile-page";

  DocumentSnapshot user;
  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _ProfileState( user: user,),
    );
  }
}

class _ProfileState extends StatelessWidget {
  static String tag = "profile-page";
  DocumentSnapshot user;
  _ProfileState({Key key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final content = Column(
      //direction: Axis.vertical,
      //textDirection: TextDirection.ltr,
    
   //mainAxisSize: MainAxisSize.max,
    //mainAxisAlignment: MainAxisAlignment.center,
      
    //crossAxisAlignment: CrossAxisAlignment.center,
    //mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
        
        Container(
          width: MediaQuery.of(context).size.width*0.5,
          padding: EdgeInsets.only(bottom: 30, top: 30, left: 20, right: 20),
          child: ClipRRect(
            borderRadius: new BorderRadius.circular(100.0),
            child: Image.network(user['photo'], fit: BoxFit.fitWidth, height: 150,)
          ) 
          
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            user['name'], textAlign: TextAlign.center,
            style: TextStyle( color: Layout.white(), fontSize: 32, letterSpacing: 1, fontWeight: 
            FontWeight.bold),
          ),
        ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 1),
        child: Text(
          user['email'], textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, 
            color: Layout.white())
        )
      ),
      ],
    ); 
    return Layout.getContent(context, content);
  }
}