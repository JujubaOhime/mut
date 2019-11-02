
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final _firebase = FirebaseAuth.instance;
  final _google = new GoogleSignIn();

  static FirebaseUser usuarioLogado;

  Future<bool> signWithGoogle() async{
    final googleAuthentication = await _google.signIn();

    final authenticated = await googleAuthentication.authentication;

    final usarioAutenticado = await _firebase.signInWithGoogle(
        idToken: authenticated?.idToken,
        accessToken: authenticated?.accessToken);
      print(usarioAutenticado.email);
      print(usarioAutenticado.displayName);
      
      Authentication.usuarioLogado = usarioAutenticado;

      return usarioAutenticado?.uid != null;
  }

    signOutWithGoogle() async{
    await _firebase.signOut();
    await _google.signOut();
  }

  Future<bool> signWithPhone(String verificacaoId, String codigoSms) async {
    final loginResult = await _firebase.signInWithPhoneNumber(verificationId: verificacaoId, smsCode: codigoSms );
    if(loginResult?.uid != null){
      return true;
    }else{
      return false;
    }
  }

  Future verifyPhoneNumber(String numeroDoCelular) async{
    await _firebase.verifyPhoneNumber(
      phoneNumber: numeroDoCelular,
      codeSent: (String verified, [int forceResend]){
        print("Foi verificado com Sucesso");
        print(verified);
      },
      verificationFailed: (AuthException autenticaoException){
        print("Ocorreu um erro");
      },
      verificationCompleted: (FirebaseUser user){
        print(user?.uid);
      },
      codeAutoRetrievalTimeout: (String timeOut){
        print(timeOut);
      },
      timeout: Duration(seconds: 30)
    );

  }
}