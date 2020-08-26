import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';


class service_accept extends StatelessWidget {
  String Service_Codes;
  String value;
  service_accept({this.value, this.Service_Codes});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.yellow,
              title: Text('VENKATESH',
              style:TextStyle(color:Color(000000))),),
          body: Center(
              child: service_entry_admins()
          )
      ),
    );
  }
}

class service_entry_admins extends StatefulWidget {

  service_acceptState createState() => service_acceptState();

}

class service_acceptState extends State {
  final ServiceCodeController = TextEditingController();
  Future service_update() async{

    // Showing CircularProgressIndicator.


    // Getting value from Controller
    String Status = 'OnProgess';
    String ServiceCode = ServiceCodeController.text;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/service_update.php';

    // Store all data with Param Name.
    var data = {'Status': Status,'ServiceCode': ServiceCode};

    // Starting Web API Call.
    http.post(url, body: json.encode(data));

  }


  final String uri = 'http://www.vnplad.com/service2go/serviceavailable.php';

  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          child: Center(

              child: Column(
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/bikeservice.png",
                      fit: BoxFit.scaleDown,
                    ),
                    Container(
                        child:FutureBuilder<List<Users>>(
                          future: _fetchUsers(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                            return ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: snapshot.data
                                    .map((user) => Card( child: ListTile(
                                  title: Text("\nService Date\t\t:\nBrand Name\t\t:\t\t"+user.brands),
                                  subtitle: Text("\nModel Name\t\t:\t\t"+user.model+"\nVersion Number\t\t:\t\t"+user.version+"\nVehicle Number\t\t:\t\t"+user.vehicle_number),
                                  trailing: Wrap(
                                      spacing: 12,
                                     // var Service_Codes =  Text(user.Service_Code),// space between two icons
                                  children: <Widget>[

                                    IconButton( icon: Icon(Icons.check),
                                        onPressed: () {
                                          service_update();
                                        }
                                    ), // icon-1
                                    IconButton( icon:   Icon(Icons.close),
                                        onPressed: () {}
                                    ),// icon-2
                                  ],
                                ),
                                )
                                ))
                                .toList(),
                            );
                          },
                        ))]))),
    );
  }
}

class Users {
  String version;
  String model;
  String brands;
  String vehicle_number;
  String Service_Code;

  Users({
    this.version,
    this.model,
    this.brands,
    this.vehicle_number,
    this.Service_Code,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      version: json['version'],
      brands: json['brands'],
      model: json['model'],
      vehicle_number: json['vehicle_number'],
      Service_Code: json['Service_Code'],
    );
  }
}
