import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/services/authentication/Authentication.dart';


class LayoutBloc extends BlocBase {
  
  final _authentication = new Authentication();
  
  final BuildContext context;
  LayoutBloc(this.context);


  changeAcount() async{
    await _authentication.signOutWithGoogle();
    await _authentication.signWithGoogle();
  }

  @override
  void dispose() {
  }
  
}