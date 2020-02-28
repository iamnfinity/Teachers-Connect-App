import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card= new Card(color:Colors.blue,
        child: new Column(
            children: <Widget>[
              new Row(children: <Widget>[ new Expanded(
                  child:
                  new Icon(Icons.arrow_back, color: Colors.black,)

              )

              ],
              ),
              new Row(children: <Widget>[
                new Expanded(
                    child: new ListTile(
                      leading: Icon(Icons.account_box, color: Colors.green, size: 26.0,),
                      title: new Text("Teachers Name"),
                      subtitle: new Text("Subject name"),
                    )

                ),
                new Expanded(
                  child: new Text("CS1"),
                )
              ],
              ),
              new Row(children: <Widget>[
                new Expanded(
                  child: new TextField(),
                ),
                new Expanded(
                  child: new ButtonBar() ,
                )
              ],
              )
            ]
        )
    );


    final sizedBox = new Container(
        child: new prefix0.SizedBox(
          height: 220.0,
          child: card,
        )
    );
    return new MaterialApp(
      title: 'my page',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new Scaffold(


        body: sizedBox,



      ),



    );
  }
}