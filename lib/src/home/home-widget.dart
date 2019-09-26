import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/login/login-widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  _logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela inicial"),),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout, 
        child: Icon(Icons.exit_to_app)
      ),
    );
  }
}