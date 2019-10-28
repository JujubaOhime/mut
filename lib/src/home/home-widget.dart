import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mut/src/login/login-widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  /*_logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela inicial"),),
      floatingActionButton: FloatingActionButton(

      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        child: Icon(Icons.exit_to_app)
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //       backgroundColor: _getBackgroundColor,
        elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.navigate_before, color: _getTextColor()),
          Text("Explore", style: TextStyle(color: _getTextColor()),),
          Icon(Icons.search, color: _getTextColor()),
        ],
      ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Expanded(
              child: CardListStateWidget(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.not_interested, color: Colors.redAccent),
                    onPressed: (){},),
                ),
                Container(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.done, color: Colors.black54),
                    onPressed: (){},),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.bookmark, color: Colors.greenAccent),
                    onPressed: (){},),
                ),
              ],
            ),
          ],
      ),
    );
  }
}

class CardListStateWidget extends StatefulWidget {
  @override
  _CardListStateWidgetState createState() => _CardListStateWidgetState();
}

class _CardListStateWidgetState extends State<CardListStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


Color _getBackgroundColor(){
  return Colors.blue;
}

Color _getTextColor(){
  return Colors.black;
}