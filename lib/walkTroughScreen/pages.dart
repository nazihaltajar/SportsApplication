import 'package:flutter/material.dart';
import 'package:sports_nazih0126/loginPart/ui/login_page.dart';


final pages = [
  new PageViewModel(
      const Color(((0xff000000))),
      'assets/soccer-icon.png',
      'Sport Days',
      'All the football fields are sorted by popularity and rating',
      'assets/football.png'
      ),
  new PageViewModel(
      const Color(((0xff444444))),
      'assets/schedule-icon.png',
      'Schedule',
      'We carefully notify all your friends after you make a reservation into the app to join you !',
      'assets/wallet.png'
      ),
  new PageViewModel(
    const Color(((0xff888888))),
    'assets/characters.png',
    'Join us!',
    'All local Football fields are categorized for your convenience and price!',
    'assets/key.png',
    ),
];

class Page extends StatelessWidget {

  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset(
                        viewModel.heroAssetPath,
                        width: 200.0,
                        height: 200.0
                        ),
                    ),
                  ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      viewModel.title,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 34.0,
                        ),
                      ),
                    ),
                  ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 75.0),
                    child: new Text(
                      viewModel.body,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                new RaisedButton(onPressed: (){{Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()
                        ));}},color: Colors.amber,shape: RoundedRectangleBorder(),elevation: 1.0,splashColor: Colors.blueGrey,child: Text('Skip!'),)
              ]
              ),
          )
        );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
      this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetPath,
      );
}
