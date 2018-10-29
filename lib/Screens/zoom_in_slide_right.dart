import 'package:flutter/material.dart';


class ZoomScaffold extends StatefulWidget {
//  final Widget loginScreen; --------de aici continui
  final Widget menuScreen;
  final Screen contentScreen;

  ZoomScaffold({
//    this.loginScreen,
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold>
    with TickerProviderStateMixin {
  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);

  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    menuController = new MenuController(
      vsync: this,
      ) //initializam menuController
      ..addListener(() => setState(
              () {})); //adaugam un listener care de fiecare data cand menucontroller se schimba va chema
    // set state care va reface /actualizeaza ecranul principal
  }

  @override
  void dispose() {
    menuController
        .dispose(); // change notifiers te obliga sa folosesti dispose pentru ati anula listeneri pt tine

    super.dispose();
  }

  createContentDisplay() {
    return zoomAndSlideContent(Container(
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          leading: IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                menuController.toggle();
              }),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            widget.contentScreen.title,
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 25.0,
              ),
            ),
          ),
        body: widget.contentScreen.contentBuilder(context),
        ),
      ));
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount = 275.0 *
        slidePercent; //inloc de slideamount = slidePercent  in loc sa folosim valorile directe vom folosi valorile intermediare pentru a realiza animatia
    final contentScale = 1.0 -
        (0.2 * scalePercent); // inloc de contentScale vom folosii scalePercent
    final cornerRadius = 10.0 *
        (menuController
            .percentOpen); //pt corner radius nu am facut nimic deci vom folosi percent open in mod direct

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
              color: Colors.black26,
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0)
        ]),
        child: ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[widget.menuScreen, createContentDisplay()],
      );
  }
}

class ZoomScaffoldMenuController extends StatefulWidget {
  //deci acest zoomsscaffloldmenucontroller o sa se uite in tree o sa caute acel scaffold state
  final ZoomScaffoldBuilder
  builder; //si va scoate la suprafata acel scaffoldState.menuController  si il vom returna

  ZoomScaffoldMenuController({
    this.builder,
  });

  @override
  ZoomScaffoldMenuControllerState createState() {
    return new ZoomScaffoldMenuControllerState();
  }
}

class ZoomScaffoldMenuControllerState
    extends State<ZoomScaffoldMenuController> {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = getMenuController(context);
    menuController.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    // cand folosim aceasta metoda ciudata vrem sa spunem ca undeva deasupra in widget tree-ul nostru exista un zoomScaffoldState
    // si vrem sa ne referim la el acest zoomscaffold este defapt clasa ce detine Menu controllerul
    //deci ecranul nostru principal va fii mai mic decat zoomscaffoldulState  pentru ai permite sa se uite dupa un stramos de tipul zoomscaffoldstate
    final scaffoldState =
    context.ancestorStateOfType(new TypeMatcher<_ZoomScaffoldState>())
    as _ZoomScaffoldState;
    return scaffoldState.menuController;
  }

  _onMenuControllerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, getMenuController(context));
  }
}

typedef Widget ZoomScaffoldBuilder(
    BuildContext context, MenuController menuController);

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({this.title, this.background, this.contentBuilder});

}

class MenuController extends ChangeNotifier {
  //ChangeNotifiers ne va permite sa folosim listeners
  //si sa ii notificam de schimbari
  final TickerProvider vsync;
  final AnimationController _animationController;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  MenuState state = MenuState.closed;

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  //trebe sa definim un menuControler
  // care va avea nevoie in primul rand de un menuState()
  closed,
  opening,
  open,
  closing,
}
