import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';



class service_accept extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(

            title: Text('Service2Go'),
            automaticallyImplyLeading: true,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
          ),

          body: Center(
              child: service_accepts()
          )
      ),
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => new login(),
      },
    );
  }

}

class service_accepts extends StatefulWidget {

  service_acceptsState createState() => service_acceptsState();

}

class service_acceptsState extends State {

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  bool visit = false;

  bool pickup = false;
  String t = "false";
  String vt = "false";

  void toggleCheckbox(bool value) {

  }

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  Future loginpage() async {
    Navigator.pushReplacementNamed(context, "/loginpage");
  }

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String model = nameController.text;
    String version = mobileController.text;
    String vnumber = passwordController.text;
    String address = confirmpasswordController.text;
    String visit = vt;
    String pickup = t;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/bookvehicle.php';

    // Store all data with Param Name.
    var data = {
      'name': model,
      'mobile': version,
      'password': vnumber,
      'confirmpassword': address,
      'visit': visit,
      'pickup': pickup,
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(


        children: <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
        ],
      ),




    );

  }

  void something() {
    setState(() {
      if (pickup) {
        t = "false";
        pickup = !pickup;
      } else {
        t = "true";
        pickup = !pickup;
      }
    }
    );
  }
  void somethings(){
    setState(() {
      if(visit){
        vt = "false";
        visit = !visit;
      }else{
        vt = "true";
        visit = !visit;
      }

    });

  }}