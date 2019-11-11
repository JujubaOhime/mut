import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';

class AboutPage extends StatelessWidget {
  static String tag = "about-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _AboutPageState(),
    );
  }
}

class _AboutPageState extends StatelessWidget {
  static String tag = "about-page";

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
        )
        ),
      ),
    );
  }
}
