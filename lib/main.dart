import 'package:flutter/material.dart';
import 'package:mappinglist/home.dart';
import 'package:mappinglist/loadingsplash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(appBarTheme: AppBarTheme(color: Colors.blue)),
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        // '/location': (context) => ChooseLocation(),
      },
    );
  }
}
