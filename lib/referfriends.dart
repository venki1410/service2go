import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';
import 'package:service2go/myrewards.dart';
import 'package:service2go/referfriends.dart';
import 'package:service2go/todayoffers.dart';



class referfriends extends StatelessWidget {
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
    '/myrewards': (BuildContext context) => new myrewards(),
    '/todayoffers': (BuildContext context) => new todayoffers(),
    '/referfriends': (BuildContext context) => new referfriends(),
      },
    );
  }
}

class listpage extends StatefulWidget {

  listpageState createState() => listpageState();

}

class listpageState extends State {


  Future bookvehicle() async{

    Navigator.pushReplacementNamed(context, "/bookservice");
  }
  Future referfriend() async{

    Navigator.pushReplacementNamed(context, "/loginpage");
  }
  Future todayoffer() async{

    Navigator.pushReplacementNamed(context, "/loginpage");
  }
  Future rewards() async{

    Navigator.pushReplacementNamed(context, "/loginpage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Refer Your Friends & Earn",
                          style: TextStyle(fontSize: 21))),

                  Divider(),

                  RaisedButton(
                    onPressed: bookvehicle,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Book Now'),
                  ),





                ],
              ),
            )));
  }



}

