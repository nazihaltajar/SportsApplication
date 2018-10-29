import 'package:flutter/material.dart';
import 'package:sports_nazih0126/Screens/menu_screen.dart';
import 'package:sports_nazih0126/Screens/sportsdays_screen.dart';
import 'package:sports_nazih0126/walkTroughScreen/mainwalktroughscreen.dart';
import 'package:sports_nazih0126/Screens/zoom_in_slide_right.dart';



void main() {
  runApp(MaterialApp(
    theme: ThemeData(),
    home: MyHomePageWalktrough(),
    ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var activeScreen = sportsdaysScreen;

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children:<Widget>[
          new ZoomScaffold(menuScreen: new MenuScreen(), contentScreen: activeScreen,),
        ]);
  }
}

