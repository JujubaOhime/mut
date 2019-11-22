import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/login/login-bloc.dart';
import 'package:mut/src/login/login-widget.dart';
import 'package:mut/src/pages/home-widget.dart';
import 'package:mut/src/pages/matches.dart';
import 'package:mut/src/pages/my-clothes.dart' as prefix0;
import 'package:mut/src/pages/my-clothes.dart';
import 'package:mut/src/pages/new-clothes.dart';
import 'package:mut/src/pages/profile.dart';
import 'package:mut/src/pages/sobre.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class Layout {
  static File sampleImgage;
  static String nomeImagem;

  static Scaffold getContent(BuildContext context, content) {
    _logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
    }

    LayoutBloc bloc = BlocProvider.of<LayoutBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Layout.lightPink()),
        backgroundColor: Layout.white(),
        title: Image.asset('assets/transBlue.png', height: 35),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        centerTitle: true,
        actions: <Widget>[
          new IconButton( icon: new Icon(Icons.favorite), onPressed: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(MatchWidget.tag);
          }, ),
        ],
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30)
        ),
        child: Drawer(
          child: Container(
          color: Layout.white(),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(Authentication.usuarioLogado.displayName,
                    style: TextStyle(color: Layout.white())),
                accountEmail: Text(Authentication.usuarioLogado.email,
                    style: TextStyle(color: Layout.white())),
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
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Transgender_Pride_flag.svg/1280px-Transgender_Pride_flag.svg.png"),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.home, color: Layout.lightBlue(),
                ),
                title: Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(HomeWidget.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.plusCircle, color: Layout.lightBlue()),
                title: Text("Adicionar Roupa"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(NewClothesPage.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.tshirt, color: Layout.lightBlue()),
                title: Text("Minhas Roupas"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(MyClothes.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.userAlt, color: Layout.lightBlue()),
                title: Text("Perfil"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ProfilePage.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.infoCircle, color: Layout.lightBlue()),
                title: Text("Sobre"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(AboutPage.tag);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.doorOpen, color: Layout.lightBlue()),
                title: Text("Sair"),
                onTap: () {
                  _logout();
                },
              ),
            ],
          ),
        )),
      ),

      backgroundColor: Layout.lightPink(),
      body: content, //parametro do scaffold
    );
  }

  static Color primary([double opacity = 1]) =>
      Color.fromRGBO(229, 176, 97, opacity); //'amarelo'
  static Color lightPink() =>
      Color.fromRGBO(247 , 168 , 184, 1);
  static Color lightBlue([double opacity = 1]) =>
      Color.fromRGBO(85, 205, 252, opacity); //'azul'
  static Color light([double opacity = 1]) =>
      Color.fromRGBO(255, 247, 209, opacity); //papel
  static Color white([double opacity = 1]) =>
      Color.fromRGBO(250, 250, 250, opacity); //branco
  static Color font([double opacity = 1]) =>
      Color.fromRGBO(43, 53, 56, opacity); //cinza

  static Color accent([double opacity = 1]) =>
      Color.fromRGBO(99, 24, 29, opacity); //vinho
  static Color accentLight([double opacity = 1]) =>
      Color.fromRGBO(127, 24, 29, opacity); //vermelho


}
