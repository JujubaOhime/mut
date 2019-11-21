import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mut/src/layout/layout-bloc.dart';
import 'package:mut/src/layout/layout.dart';

class NewClothesPage extends StatelessWidget {
  static String tag = "newClothes-page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutBloc>(
      bloc: LayoutBloc(context),
      child: _NewClothesPageState(),
    );
  }
}

class _NewClothesPageState extends StatelessWidget {
  static String tag = "newClothes-page";

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
