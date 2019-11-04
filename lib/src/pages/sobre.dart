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
        child: Text("Este app foi criado por Amélia e João"),
      ),
    );
  }
}
