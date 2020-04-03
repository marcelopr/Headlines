import 'package:flutter/material.dart';
import 'package:newsapp/state/news_provider.dart';
import 'package:newsapp/state/theme_provider.dart';
import 'package:newsapp/ui/screens/home.dart';
import 'package:newsapp/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<ThemeState>(
        create: (_) => ThemeState(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, themeState, child) {
        return MaterialApp(
          title: 'HeadLines',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: ChangeNotifierProvider(
            create: (_) => NewsState(),
            child: Home(),
          ),
        );
      },
    );
  }
}
