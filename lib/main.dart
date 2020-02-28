import 'package:flutter/material.dart';

// Import Routes Generator
import 'routes_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teachers App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes_generator.onGenerateRoute,
      initialRoute: "/",
    );
  }
}
