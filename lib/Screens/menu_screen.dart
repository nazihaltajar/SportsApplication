import 'package:flutter/material.dart';
import 'package:sports_nazih0126/Screens/other_screen.dart';
import 'package:sports_nazih0126/loginPart/ui/login_page.dart';

import 'package:sports_nazih0126/Screens/zoom_in_slide_right.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  AnimationController
  titleAnimationController; //animation con troller pentru a controla titlul

  @override
  void initState() {
    super.initState();
    titleAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  createMenuTitle(MenuController menuController) {
    switch (menuController.state) {
      case MenuState.open:
      case MenuState.opening:
        titleAnimationController.forward();
        break;

      case MenuState.closed:
      case MenuState.closing:
        titleAnimationController.reverse();
        break;
    }

    return new AnimatedBuilder(
        animation: titleAnimationController,
        child: new OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.topLeft,
          child: new Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Text(
              'Sports Days',
              style: new TextStyle(
                color: Colors.white12,
                fontSize: 40.0,
                fontFamily: 'mermaid',
                ),
              textAlign: TextAlign.left,
              softWrap: false,
              ),
            ),
          ),
        builder: (BuildContext context, Widget child) {
          return new Transform(
            transform: new Matrix4.translationValues(
                420.0 * (1.0 - titleAnimationController.value)-30.0,
                0.0,
                0.0
                ),
            child: child,
            );
        });
  }

  createMenuItems(MenuController menuController) {

    final titles = ['Create Your Team','Make a reservation! ' ,'Find your friends!','Settings!'];
    final selectedIndex = 0 ;
    final List<Widget> listItems = [];
    final animationIntervalDuration = 0.5;
    final perListItemDelay = menuController.state != MenuState.closing ? 0.15 : 0.0;

    for (var i = 0 ; i<titles.length;++i){
      final animationIntervalStart = i * perListItemDelay;
      final animationIntervalEnd = animationIntervalStart + animationIntervalDuration;

      listItems.add(new AnimatedMenuListItem(
        menuState:menuController.state,
        duration: const Duration(milliseconds: 600 ),
        curve: new Interval (
            animationIntervalStart,
            animationIntervalEnd,
            curve:Curves.easeOut),
        menuListItem: new _MenuListItem(
          title: titles[i],
          isSelected: i == selectedIndex,
          onTap: () {
            menuController.close();
          },
          ),
        ),);
    }


    return new Transform(
      //miscam toata coloana cu acest widget
      transform: new Matrix4.translationValues(0.0, 225.0, 0.0),
        child: Column(children: listItems),
      );
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        return new Container(
          width: double.infinity,
          height: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('assets/crop.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                new ColorFilter.mode((Colors.black54), BlendMode.multiply)),
            ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(children: <Widget>[
              createMenuTitle(menuController),
              createMenuItems(menuController),
            ]),
            ),
          );
      },
      );
  }
}


class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  final MenuState menuState;
  final Duration duration;

  AnimatedMenuListItem({
    this.menuListItem,
    this.menuState,
    this.duration,
    curve ,
  }) :super(duration : duration , curve : curve);
  @override
  _AnimatedMenuListItemState createState() => _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState extends AnimatedWidgetBaseState<AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;


  @override
  void forEachTween(TweenVisitor visitor) {
    var slide , opacity;

    switch (widget.menuState){
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;
        opacity = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
    }


    _translation = visitor(
      _translation,
      slide,
          (dynamic value ) => new Tween<double>(begin: value),
      );

    _opacity = visitor(
      _opacity,
      opacity,
          (dynamic value ) => new Tween<double>(begin : value),
      );


  }


  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: _opacity.evaluate(animation),
      child: new Transform(transform: new Matrix4.translationValues(0.0, _translation.evaluate(animation), 0.0),
                             child: widget.menuListItem,),

      );
  }


}




class _MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;


  _MenuListItem({this.title, this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected ? null :  () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ZoomScaffold(menuScreen: new MenuScreen(), contentScreen: otherScreen,)),
        ),
      child: new Container(
        width: double.infinity,
        child: new Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 35.0, bottom: 15.0),
          child: new Text(
            title,
            style: new TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 20.0,
              fontFamily: 'bebas-neue',
              letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      );
  }
}
