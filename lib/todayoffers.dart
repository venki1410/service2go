import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
//import 'package:flutter_otp/flutter_otp.dart';
import 'package:http/http.dart' as http;
import 'package:service2go/myrewards.dart';
import 'package:service2go/listpage.dart';


Future<Album> fetchAlbum() async {
  final response =
  await http.get('http://www.vnplad.com/service2go/offer.php');

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
  final String offer;

  Album({  this.offer});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      offer: json['offer'],
    );
  }
}

class todayoffers extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/listpages': (BuildContext context) => new listpages(),
        '/todayoffers': (BuildContext context) => new todayoffers(),
      },
      home: Scaffold(
          appBar: AppBar( automaticallyImplyLeading: true,
            title: Text('Service2Go'),

              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => Navigator.pushReplacementNamed(context, "/listpages"),
              ),),

          body: Center(
              child: listpage(),

          )

      ),

    );
  }
}

class listpage extends StatefulWidget {
  listpage({Key key}) : super(key: key);

  @override
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

    Navigator.pushReplacementNamed(context, "/bookservice");
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
                      child: Text("Today's Offer",
                          style: TextStyle(fontSize: 21))),

                  Divider(),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.pink,
                      height: 300,
                      child: ClipRect(
                        child: Banner(
                          message: "Offer's",
                          location: BannerLocation.topEnd,
                          color: Colors.red,
                          child: Container(
                            color: Colors.pink,
                            height: 100,
                            child: Center(
                              child: FutureBuilder<Album>(
                                future: futureAlbum,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data.offer);
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }

                                  // By default, show a loading spinner.
                                  return CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),





                  RaisedButton(
                    onPressed: bookvehicle,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Claim & Book'),
                  ),





                ],

              ),

            )));
  }

}

class myModel {
  final int id;
  final String offer;

  myModel(this.id, this.offer);
}
