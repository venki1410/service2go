import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class admin extends StatelessWidget {
  const admin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(child: service_entry_admins()),
      Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
      Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
    ];
    final _kTabs = <Tab>[
      Tab(text: 'ORDERS'),
      Tab(text: 'STATUS'),
      Tab(text: 'RESULT'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin',style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellowAccent,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _kTabs,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
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

              child: Container(
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
                        )))));
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
