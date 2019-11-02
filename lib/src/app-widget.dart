import 'package:mut/src/app-bloc.dart';
import 'package:mut/src/home/home-widget.dart';
import 'package:mut/src/login/login-widget.dart';


import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

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
          //"/screen2": (context) => Screen2(),
          //"/screen3": (context) => Screen3(),
        },
        
      )
      
    );
  }
}