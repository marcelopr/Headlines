import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Na'),
            Text('Hora', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
