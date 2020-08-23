import 'package:flutter/material.dart';
import 'package:service2go/reedempoints.dart';

class redeempage extends StatelessWidget {

  String value;
  redeempage({this.value});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: Text('Service2Go')),
          body: Center(
              child: listpage()
          )
      ),
      routes: <String, WidgetBuilder>{
        '/reedempoints': (BuildContext context) => new reedempoints(),
      },
    );
  }
}

class listpage extends StatefulWidget {

  listpageState createState() => listpageState();

}

class listpageState extends State {


  Future reedempoints() async{

    Navigator.pushReplacementNamed(context, "/reedempoints");
  }
  Future referfriend() async{

    Navigator.pushReplacementNamed(context, "/referfriends");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50),
                  ),
                  RaisedButton(
                    onPressed: reedempoints,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Reedem For Service'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                  ),
                  RaisedButton(
                    onPressed: referfriend,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Reedem Cash via Paytm'),
                  ),
                ],
              ),
            )));
  }



}

