import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/home/home-widget.dart';
import 'package:mut/src/services/authentication/Authentication.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase{

  final _authentication = new Authentication();

  final _phoneController = new BehaviorSubject<String>();
  Observable<String> get phoneFlux => _phoneController.stream;
  Sink<String> get phoneEvent => _phoneController.sink;

  final _smsController = new BehaviorSubject<String>();
  Observable<String> get smsFlux => _smsController.stream;
  Sink<String> get smsEvent => _smsController.sink;

  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);

  
  Stream<bool> get outLoading => _controllerLoading.stream;

  final BuildContext context;
  LoginBloc(this.context);


  onClickGoogle() async{
    _controllerLoading.add(true);
    if(await _authentication.signWithGoogle()){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
    } else{
      _controllerLoading.add(false);
    }
  }

  onClickTelefone() async {
    _controllerLoading.add(!_controllerLoading.value);

    await _authentication.verifyPhoneNumber(_phoneController.value);
    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }

  onClickTelefone2(String value) async {
    _controllerLoading.add(!_controllerLoading.value);

    await _authentication.verifyPhoneNumber(value);
    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }


  checkLogin() async{
    FirebaseUser usuarioAutenticado = await FirebaseAuth.instance.currentUser();
    if(usuarioAutenticado != null){
      Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (BuildContext context)=> HomeWidget()));
    }else{
      _controllerLoading.add(false);
    }
  }

  @override
  void dispose() {
    _controllerLoading.close();
    _phoneController.close();
    _smsController.close();
  }

}