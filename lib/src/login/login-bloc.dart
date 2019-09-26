import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/home/home-widget.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase{

  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);

  
  Stream<bool> get outLoading => _controllerLoading.stream;

  final BuildContext context;
  LoginBloc(this.context);

  onClickFacebook(){

  }

  onClickGoogle(){
    
  }

  onClickTelefone() async {
    _controllerLoading.add(!_controllerLoading.value);

    await Future.delayed(Duration(seconds: 2));

    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }
  @override
  void dispose() {
    _controllerLoading.close();
  }

}