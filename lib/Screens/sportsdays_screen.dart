import 'package:flutter/material.dart';
import 'package:sports_nazih0126/Screens/menu_screen.dart';
import 'package:sports_nazih0126/Screens/other_screen.dart';
import 'package:sports_nazih0126/Screens/zoom_in_slide_right.dart';



final Screen sportsdaysScreen = new Screen(
    title:  'Sports Days',
    background: new DecorationImage(
      image:new AssetImage('assets/wood_bk.jpg'),
      fit:BoxFit.cover,
      ),
    contentBuilder: (BuildContext context){
      return new ListView(
        children: <Widget>[
          new _TerenCard(
              headImageAssetPath: 'assets/teren.jpg',
              icon: Icons.send,
              iconBackgroundColor: Colors.green,
              title: 'Baza Transilvania',
              subtitle: 'Cea mai complexa baza sportiva',
              heartCount: 421),
          new _TerenCard(
            headImageAssetPath: 'assets/teren5.jpg',
            icon: Icons.beenhere,
            iconBackgroundColor: Colors.cyan,
            title: 'Winners Cluj',
            subtitle: 'Cea mai complexa baza sportiva',
            heartCount: 323,
            ),
          new _TerenCard(
            headImageAssetPath: 'assets/teren3.jpg',
            icon: Icons.star,
            iconBackgroundColor: Colors.red,
            title: 'Interservisa Cluj',
            subtitle: 'Cea mai complexa baza sportiva',
            heartCount: 324,
            ),
          new _TerenCard(
            headImageAssetPath: 'assets/teren3.jpg',
            icon: Icons.star,
            iconBackgroundColor: Colors.red,
            title: 'Clujana ',
            subtitle: 'Cea mai complexa baza sportiva',
            heartCount: 564,
            )
        ],
        );
    }
    );





class _TerenCard extends StatelessWidget {


  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartCount;
  final RaisedButton button;




  _TerenCard(
      {this.headImageAssetPath,
        this.icon,
        this.iconBackgroundColor,
        this.title,
        this.subtitle,
        this.heartCount,
        this.button
      });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: new Card(
        color: Colors.black12,
        elevation: 10.0,
        child: new Column(
          children: <Widget>[
            new Image.asset(
              headImageAssetPath,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
              ),
            new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(15.0)),
                      ),
                    child: new Icon(
                      icon,
                      color: Colors.greenAccent,
                      ),
                    ),
                  ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'mermaid',
                          ),
                        ),
                      new Text(subtitle,
                                   style: const TextStyle(
                                     fontSize: 16.0,
                                     fontFamily: 'bebas-neue',
                                     letterSpacing: 1.0,
                                     color: const Color(0xFFAAAAAAA),
                                     )),
                    ],
                    ),
                  ),
                new Container(
                  width: 2.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                          const Color(0xFFAAAAAA)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        )),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: new Column(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          ),
                        onPressed: () {
                        },
                        ),
                      new Text ('$heartCount',style: TextStyle(color: Colors.white),),


                    ],
                    ),
                  ),
              ],
              ),
            new MaterialButton(
              color:Colors.black,
              highlightColor: Colors.greenAccent,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 22.0),
                child: Text(
                  "Make a reserrvation",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    ),
                  ),
                ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZoomScaffold(menuScreen: new MenuScreen(), contentScreen: otherScreen,)),
                ),
              )],
          ),
        ),
      );

  }

}
