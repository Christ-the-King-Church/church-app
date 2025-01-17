import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'utils/color_scheme.dart';

void main() => runApp(MyApp());

/// flutter run --no-sound-null-safety
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: MAIN1,
          canvasColor: MAIN1,
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_GREY),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_GREY),
            ),
          ),
          primaryIconTheme:
              Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
          primaryTextTheme: Theme.of(context)
              .primaryTextTheme
              .apply(bodyColor: Colors.white)),
      home: Home(),
    );
  }
}
