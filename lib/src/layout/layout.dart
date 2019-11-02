import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/home/home-widget.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/login/login-bloc.dart';
import 'package:mut/src/login/login-widget.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class Layout {
  static File sampleImgage;
  static String nomeImagem;


  
  static Scaffold getContent(BuildContext context, content) {
    _logout() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
  }

    LayoutBloc bloc = BlocProvider.of<LayoutBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "MUT",
          style: TextStyle(
            fontSize: 25,
            color: Layout.white(),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, 
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(Authentication.usuarioLogado.displayName,
                    style: TextStyle(color: white())),
                accountEmail: Text(Authentication.usuarioLogado.email,
                    style: TextStyle(color: white())),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(Authentication.usuarioLogado.photoUrl),
                  ),
                  onTap: () {
                    bloc.changeAcount();
                  },
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Transgender_Pride_flag.svg/1280px-Transgender_Pride_flag.svg.png"),
                    
                  ),
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(HomeWidget.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.doorOpen),
                title: Text("Sair"),
                onTap: () {
                  _logout();
                },
              ),
            ],
          ),
        )
      ),
      backgroundColor: Layout.white(),
      body: content, //parametro do scaffold
    );

    
  }
    static Color primary([double opacity = 1]) =>
    Color.fromRGBO(229, 176, 97, opacity); //'amarelo'
    static Color secundary([double opacity = 1]) =>
    Color.fromRGBO(31, 22, 86, opacity); //'azul'
    static Color light([double opacity = 1]) =>
    Color.fromRGBO(255, 247, 209, opacity); //papel
    static Color white([double opacity = 1]) =>
    Color.fromRGBO(255, 255, 255, opacity); //branco
    static Color font([double opacity = 1]) =>
    Color.fromRGBO(43, 53, 56, opacity); //cinza

    static Color accent([double opacity = 1]) =>
    Color.fromRGBO(99, 24, 29, opacity); //vinho
    static Color accentLight([double opacity = 1]) =>
    Color.fromRGBO(127, 24, 29, opacity); //vermelho   
}