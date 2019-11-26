import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';
import 'package:mut/src/pages/profile.dart';
import 'package:mut/src/services/authentication/Authentication.dart';

class LikeWidget extends StatelessWidget {
  static String tag = "like-page";

  DocumentSnapshot user;
  LikeWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _LikeWidgetState(user: user),
    );
  }
}

class _LikeWidgetState extends StatelessWidget {
  String title(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
  DocumentSnapshot user;
  _LikeWidgetState({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _interestCard(DocumentSnapshot clothes) => Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  title(clothes['title']),
                  style: TextStyle(
                      color: Layout.white(),
                      fontSize: 25,
                      fontFamily: 'BalooBhai'),
                ),
                padding:
                    EdgeInsets.only(bottom: 10, top: 15, left: 0, right: 0),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        image: NetworkImage(clothes['photo']),
                        fit: BoxFit.cover)),
                width: MediaQuery.of(context).size.width * 0.85,
                height: 200,
                padding: EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
              ),
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('Interests')
                      .where("clothes", isEqualTo: clothes.documentID)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

                    if (clothes['uid'] == Authentication.usuarioLogado.uid) {
                      if (snapshot.data.documents.length == 0) {
                        return Center(
                          heightFactor: 1.5,
                          child: Text(
                            "Ninguem interessado",
                            style:
                                TextStyle(fontSize: 20, color: Layout.white()),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot doc = snapshot.data.documents[index];
                          return Container(
                            child: Column(
                              children: <Widget>[
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('User')
                                        .where("uid", isEqualTo: doc['uid'])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('Carregando.....');
                                      return ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          leading: Icon(
                                              FontAwesomeIcons.userAlt,
                                              color: Layout.lightBlue()),
                                          title: Text(
                                            title(doc["uname"]),
                                            style: TextStyle(
                                                color: Layout.white(),
                                                fontSize: 15),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ProfilePage(
                                                          user: snapshot.data
                                                              .documents[0],
                                                        )));
                                          });
                                    }),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  })
            ],
          ),
        );

    _interest(DocumentSnapshot doc) => Container(
        margin: const EdgeInsets.only(
          top: 0,
          left: 30,
          right: 30,
          bottom: 0,
        ),
        child: new Column(
          children: <Widget>[
            _interestCard(doc),
          ],
        ));

    final content = Column(
      children: <Widget>[
        Expanded(
            child: SizedBox(
                height: 200.0,
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Clothes')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot clothes =
                            snapshot.data.documents[index];
                        if (clothes['uid'] ==
                            Authentication.usuarioLogado.uid) {
                          return _interest(clothes);
                        }
                        return Container();
                      },
                    );
                  },
                )))
      ],
    );

    return Layout.getContent(context, content);
  }
}
