import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/ui/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeadLines',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      home: ChangeNotifierProvider(
        create: (_) => NewsState(),
        child: Home(),
      ),
    );
  }
}
