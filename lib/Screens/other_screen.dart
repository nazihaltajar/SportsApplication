import 'package:flutter/material.dart';
import 'package:sports_nazih0126/Screens/zoom_in_slide_right.dart';

final otherScreen = new Screen(
    title:'Make your reservation!',
    background: new DecorationImage(
        image: AssetImage('assets/other_screen_bk.jpg'),
        fit:BoxFit.cover,
        colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply)
        ),
    contentBuilder: (BuildContext context){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
            children:<Widget>[

              Padding(
                padding: const EdgeInsets.only(top:66.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context , int position){
                    return Column(
                      children: <Widget>[
                        new Divider(height:5.5,color: Colors.yellowAccent,),
                        Stack(
                            children:<Widget>[ new ListTile(
                              leading:
                              new Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:33.0),
                                    child: new Text('08:00',style: TextStyle(color: Colors.white,fontSize: 17.0),),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:33.0),
                                    child: new Text('09:00',style: TextStyle(color: Colors.white,fontSize: 17.0),),
                                    ),
                                ],
                                )
                              ,
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left:170.0),
                              child: new RaisedButton(onPressed: (){}, child: Text("Reserve now!",style: TextStyle(letterSpacing: 1.0),)
                                                        ,textColor: Colors.white,splashColor: Colors.red,color:Colors.white30,),
                              )
                            ]),
                      ],
                      );
                  },

                  itemCount: 22,
                  padding: const EdgeInsets.all(14.5),
                  ),
                ),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(child: _buildContent(),
                                 ),
                ),
            ]),

        );
    }
    );

Widget _buildContent() {
  return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext content, int index) {
        return _buildHorizontalList(parentIndex: index);
      });
}

Widget _buildHorizontalList({int parentIndex}) {
  var colors = [

    Colors.yellowAccent,


  ];
  double height = 70.0;

  return Stack(
      children:<Widget>[

        SizedBox(
          height: height,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 31,
              itemBuilder: (BuildContext content, int index) {
                return _buildItem(
                  index: index + 1,
                  color: colors[(parentIndex + index) % colors.length],
                  parentSize: height,
                  );
              }),
          ),
      ]);
}

Widget _buildItem({int index, Color color, double parentSize}) {
  double edgeSize = 8.0;
  double itemSize = parentSize - edgeSize * 2.0;
  return Container(
      padding: EdgeInsets.all(
          edgeSize
          ),
      child: SizedBox(
        width: itemSize,
        height: itemSize,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              ),
            child: Center(
              child:Text(
                '$index',
                style: TextStyle(fontSize: 12.0, color: Colors.black),
                ),
              ),
            ),
          ),
        ));
}
