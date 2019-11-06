import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/model/Contact.dart';

/*class MatchWidget extends StatelessWidget{
  static String tag = "match-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _MatchWidgetState(),
    );
  }

}

class _MatchWidgetState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout.getContent(
      context,
      Center(
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              "Este app foi criado por Amélia e João",
              style: TextStyle(
                fontSize: 25,
                color: Layout.white(),
              ),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}*/

class MatchWidget extends StatefulWidget {
  static String tag = "match-page";

  @override
  _MatchWidgetState createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {

  List<Contact> ContactList = [
    Contact("joao", "rio das ostras", "https://pbs.twimg.com/media/DFCcCbKW0AIAUlj?format=jpg&name=360x360"),
    Contact("thales", "rio das ostras", "https://pbs.twimg.com/media/DFCcCbKW0AIAUlj?format=jpg&name=360x360"),
    Contact("peres", "rio das ostras", "https://pbs.twimg.com/media/DFCcCbKW0AIAUlj?format=jpg&name=360x360"),
    Contact("pericles", "rio das ostras", "https://cdn-ofuxico.akamaized.net/img/upload/noticias/2018/08/17/periclao_327483_36.jpg"),
    Contact("Sergio", "rio das ostras", "https://pbs.twimg.com/media/DFCcCbKW0AIAUlj?format=jpg&name=360x360")

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
      itemCount: ContactList.length,
      itemBuilder: (context, indice){

        Contact c = ContactList[indice];
        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            backgroundColor: Colors.redAccent,
            backgroundImage: NetworkImage(c.photo),
          ),
          title: Text(
            c.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          subtitle: Text(
            c.description,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14
            ),
          ),
        );
      },
    )
    );
  }
}
