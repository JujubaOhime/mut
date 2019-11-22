import 'package:mut/src/app-bloc.dart';
import 'package:mut/src/login/login-widget.dart';


import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mut/src/pages/home-widget.dart';
import 'package:mut/src/pages/matches.dart';
import 'package:mut/src/pages/my-clothes.dart';
import 'package:mut/src/pages/new-clothes.dart';
import 'package:mut/src/pages/profile.dart';
import 'package:mut/src/pages/sobre.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return BlocProvider<AppBloc>(
      bloc: AppBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: LoginWidget(),
        initialRoute: '/',
        routes: {
          "home-page": (context) => HomeWidget(),
          'about-page':(context) => AboutPage(),
          'match-page': (context) => MatchWidget(),
          'newClothes-page': (context) => NewClothesPage(),
          'profile-page': (context) => ProfilePage(),
          'myClothes-page': (context) => MyClothes(),
          //"/screen2": (context) => Screen2(),
          //"/screen3": (context) => Screen3(),
        },
        
      )
      
    );
  }
}