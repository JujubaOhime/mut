import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/login/login-bloc.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(context),
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Transgender_Pride_flag.svg/1280px-Transgender_Pride_flag.svg.png",
                fit: BoxFit.cover),
            Container(
              color: Colors.grey[700].withOpacity(0.1),
            ),
            ///SingleChildScrollView(child: _LoginContent()),
            _LoginContent()
          ],
        ),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {

  



  Future<String> createAlertDialog(BuildContext context){
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    //0bloc.checkLogin();
    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Escreva Seu Telefone"),
        content: TextField(
          controller: customController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "+5521999999999"
          )
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Confirmar"),
            onPressed: (){
              //onChanged: bloc.phoneEvent.add;
              Navigator.of(context).pop(customController.text.toString());
              
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    //bloc.checkLogin();

    _botoes() {
      return Column(
        children: <Widget>[
          RaisedButton.icon(
            color: Colors.green,
            textColor: Colors.white,
            icon: Icon(Icons.phone),
            label: Text("Login com Telefone"),
            onPressed: (){
              createAlertDialog(context).then((onValue){
                //onChanged: bloc.phoneEvent.add;
                    print(onValue);
                    bloc.onClickTelefone2(onValue);
                
               
              });
            }
            //bloc.onClickTelefone,
          ),
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            icon: Icon(FontAwesomeIcons.google),
            label: Text("Login com Google  "),
            onPressed: bloc.onClickGoogle,
          ),
          
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/trans.png',
        height: 150,),
        //FlutterLogo(
          //size: 72,
        //),
        Container(
          height: 100,
        ),
        StreamBuilder(
          stream: bloc.outLoading,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return AnimatedCrossFade(
              firstChild: _botoes(),
              secondChild: Padding(
                padding: const EdgeInsets.all(0.0),
                child: CircularProgressIndicator(),
              ),
              duration: Duration(milliseconds: 500, ),
              crossFadeState: snapshot.data ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            );
          },
        ),
      ],
    );
  }
}
