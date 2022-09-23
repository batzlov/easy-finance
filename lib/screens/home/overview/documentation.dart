import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:easy_finance/shared/constants.dart';

class Documentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          title: Text('Dokumentation'),
          backgroundColor: appBarColor,
        ),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString("assets/docs.md"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) 
          {
            return Markdown(data: snapshot.data);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
      }),
    );
  }
}