import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';
import 'package:service2go/myrewards.dart';
import 'package:service2go/referfriends.dart';
import 'package:service2go/todayoffers.dart';

Future<Album> fetchAlbum() async {
  final response =
  await http.get('http://vnplad.com/service2go/fetch_points.php/${value}',  headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonresponse = json.decode(response.body);
    return Album.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final earnpoints;

  Album({  this.earnpoints});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      earnpoints: json['earnpoints'],

    );
  }

}


class reedempoints extends StatelessWidget {

  String value;
  reedempoints({this.value});
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

  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();

  }
  Future bookvehicle() async{

    Navigator.pushReplacementNamed(context, "/loginpage");
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
                      child: Text("Total Points Earned",
                          style: TextStyle(fontSize: 21))),

                  Divider(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total Points"),
                        Container(
                            width: 280,
                            padding: EdgeInsets.all(10.0),
                            child:FutureBuilder<Album>(
                              future: futureAlbum,
                              builder: (context,  snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.earnpoints, textAlign: TextAlign.center);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                // By default, show a loading spinner.
                                return CircularProgressIndicator();
                              },
                            ),
                        ),

                      ]
                  ),
                  RaisedButton(
                    onPressed: bookvehicle,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Burn'),
                  ),





                ],
              ),
            )));
  }



}

