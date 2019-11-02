import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/login/login-widget.dart';

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
       final content = StreamBuilder(

       );
      return Layout.getContent(context, content);
    }

  //@override
  //_HomeWidgetState createState() => _HomeWidgetState();
}

/*class _HomeWidgetState extends StatelessWidget {

  /*_logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
  }*/
  
}*/

/*floatingActionButton: FloatingActionButton(
        onPressed: _logout, 
        child: Icon(Icons.exit_to_app)
      ),
      */