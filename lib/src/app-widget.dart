import 'package:mut/src/app-bloc.dart';
import 'package:mut/src/login/login-widget.dart';


import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return BlocProvider<AppBloc>(
      bloc: AppBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginWidget()
      )
      
    );
  }
}