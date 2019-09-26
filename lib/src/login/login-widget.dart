import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/login/login-bloc.dart';


class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(),  
      child: _LoginContent(),
      
    );
  }
}

class _LoginContent extends StatelessWidget{
  @override 
  Widget build(BuildContext context){

    _botoes(){
      return Column(
        children: <Widget>[
          RaisedButton.icon(icon: Icon(Icons.phone), 
          label: Text("Login com Telefone"), 
          onPressed: () {},)
        ],
      );
    }
    return Material(
      child: Column(
        children: <Widget>[
          FlutterLogo(size: 72,),
        ],
      )
    );
  }
}