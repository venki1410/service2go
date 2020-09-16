import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class admin extends StatelessWidget {
  const admin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Future LogOut()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('mobile');
      Navigator.pushReplacementNamed(context, "/login");
    }

    Future profile()async{
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) =>usrs() ));
    }



    final _kTabPages = <Widget>[
      Center(child: service_entry_admins()),
      Center(child: service_entry_Status()),
      Center(child: service_entry_Result()),
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
          backgroundColor: Colors.amber,
          actions: <Widget>[
            IconButton( icon:   Icon(Icons.person_outline,color: Colors.black),
                onPressed: () {
                  profile();

                }),

            IconButton( icon:   Icon(Icons.input,color: Colors.black),
                onPressed: () {
                  LogOut();

                })

          ],
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
  bool eyes = true;
  final ServiceCodeController = TextEditingController();
  Future service_update(String sc,String st) async{
    String ServiceCode = sc;
    String Status = st;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/service_update.php';

    // Store all data with Param Name.
    var data = {'Status': Status,'ServiceCode': ServiceCode};

    // Starting Web API Call.
    http.post(url, body: json.encode(data));
    setState(() {
      eyes = false;
    });

  }


  final String uri = 'http://www.vnplad.com/service2go/serviceavailable.php/orders';

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
                      Container(
                          child:FutureBuilder<List<Users>>(
                            future: _fetchUsers(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                              return ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary:false,
                                children: snapshot.data
                                    .map((user) => Card( child: ListTile(
                                  title: Text("\nService Date\t\t:\nBrand Name\t\t:\t\t"+user.brands),
                                  subtitle: Text("\nModel Name\t\t:\t\t"+user.model+"\nVersion Number\t\t:\t\t"+user.version+"\nVehicle Number\t\t:\t\t"+user.vehicle_number),
                                  trailing: Wrap(
                                    spacing: 12,
                                    // var Service_Codes =  Text(user.Service_Code),// space between two icons
                                    children: <Widget>[

                                      IconButton( icon: Icon(Icons.check,color: Colors.green),
                                          onPressed: () {
                                            String service_code=user.Service_Code;
                                            String status = "accepted";
                                            service_update(service_code,status);
                                            snapshot.data.removeWhere((user) => user.Service_Code == service_code);
                                          }
                                      ), // icon-1
                                      IconButton( icon:   Icon(Icons.close,color: Colors.pink),
                                          onPressed: () {
                                            String service_code=user.Service_Code;
                                            String status = "cancelled";
                                            service_update(service_code,status);
                                            snapshot.data.removeWhere((user) => user.Service_Code == service_code);

                                          }
                                      ),// icon-2
                                    ],
                                  ),

                                )))
                                    .toList(),
                              );
                            },
                          ))]))));
  }
}





class service_entry_Status extends StatefulWidget {

  service_acceptStatus createState() => service_acceptStatus();

}

class service_acceptStatus extends State {
  final ServiceCodeController = TextEditingController();
  Future service_update(String sc,String st) async{
    String ServiceCode = sc;
    String Status = st;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/service_update.php';

    // Store all data with Param Name.
    var data = {'Status': Status,'ServiceCode': ServiceCode};

    // Starting Web API Call.
    http.post(url, body: json.encode(data));


  }


  final String uri = 'http://www.vnplad.com/service2go/serviceavailable.php/status';

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
                          primary:false,
                          shrinkWrap: true,
                          children: snapshot.data
                              .map((user) => Card( child: ListTile(
                            title: Text("\nService Date\t\t:\nBrand Name\t\t:\t\t"+user.brands),
                            subtitle: Text("\nModel Name\t\t:\t\t"+user.model+"\nVersion Number\t\t:\t\t"+user.version+"\nVehicle Number\t\t:\t\t"+user.vehicle_number),
                            trailing: Wrap(
                              spacing: 12,
                              // var Service_Codes =  Text(user.Service_Code),// space between two icons
                              children: <Widget>[

                                IconButton( icon: Icon(Icons.check,color: Colors.green),
                                    onPressed: () {
                                      String service_code=user.Service_Code;
                                      snapshot.data.removeWhere((user) => user.Service_Code == service_code);
                                      String status = "completed";
                                      service_update(service_code,status);
                                    }
                                ), // icon-1
                                // icon-2
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



class service_entry_Result extends StatefulWidget {

  service_acceptResult createState() => service_acceptResult();

}

class service_acceptResult extends State {
  final ServiceCodeController = TextEditingController();
  Future service_update(String sc,String st) async{
    String ServiceCode = sc;
    String Status = st;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/service_update.php';

    // Store all data with Param Name.
    var data = {'Status': Status,'ServiceCode': ServiceCode};

    // Starting Web API Call.
    http.post(url, body: json.encode(data));

  }


  final String uri = 'http://www.vnplad.com/service2go/serviceavailable.php/result';

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
        body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        children: <Widget>[
                          Container(
                              child:FutureBuilder<List<Users>>(
                                future: _fetchUsers(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                                  return ListView(
                                    scrollDirection: Axis.vertical,
                                    primary:false,
                                    shrinkWrap: true,
                                    children: snapshot.data
                                        .map((user) => Card( child: ListTile(
                                      title: Text("\nService Date\t\t:\nBrand Name\t\t:\t\t"+user.brands),
                                      subtitle: Text("\nModel Name\t\t:\t\t"+user.model+"\nVersion Number\t\t:\t\t"+user.version+"\nVehicle Number\t\t:\t\t"+user.vehicle_number+"\n\nSTATUS\t\t:\t\t"+user.sstatus),
                                      trailing: Wrap(
                                        spacing: 12,
                                        // var Service_Codes =  Text(user.Service_Code),// space between two icons
                                        children: <Widget>[

                                          // icon-2
                                        ],
                                      ),
                                    )
                                    ))
                                        .toList(),
                                  );
                                },
                              ))])))));
  }
}

class usrs extends StatelessWidget {

  Widget build(BuildContext context) {
    return
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(

            appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go', style: TextStyle(color: Colors.black)),
            ),
            body: Center(
                child:profileusrs()
            ),
          )
      );
  }
}

class profileusrs extends StatefulWidget {

  profileusrsState createState() => profileusrsState();

}
class Albumprofileuser {
  final username;
  final mode;
  final mobile_number;

  Albumprofileuser({  this.username, this.mode, this.mobile_number});

  factory Albumprofileuser.fromJson(Map<String, dynamic> json) {
    return Albumprofileuser(
      username: json['username'],
      mode: json['mode'],
      mobile_number: json['mobile_number'],
    );
  }
  Future setMode() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('mode',mode);
  }

  @override
  void initState(){
    setMode();

  }
}


class profileusrsState extends State {
  String mobile ="";


  Future getMobile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mobile = preferences.getString('mobile');


    });
  }
  Future<Albumprofileuser> fetchprofileuser() async {
    String url ='http://www.vnplad.com/service2go/usr.php/';
    String uri = url + mobile;
    final response =
    await http.get(uri,  headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonresponse = json.decode(response.body);
      return Albumprofileuser.fromJson(jsonresponse[0]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  @override
  void initState(){
    getMobile();
  }
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25),
              ),
              CircleAvatar(
                  radius: 80,
                  child:IconButton(padding: EdgeInsets.zero,icon:Icon(Icons.perm_identity,size: 50.0,), onPressed: () {  },)
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Container(
                  child: FutureBuilder<Albumprofileuser>(
                    future: fetchprofileuser(),
                    builder: (context,  snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: <Widget>[
                          Card(
                              color: Colors.white,
                              margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                              child:ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.amber,
                                  ),
                                  title:Text(snapshot.data.username,style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                                  ))),
                          Card(
                              color: Colors.white,
                              margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                              child:ListTile(
                                  leading: Icon(
                                    Icons.phone,
                                    color: Colors.amber,
                                  ),
                                  title:Text(snapshot.data.mobile_number,style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                                  )))]);


                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )),


            ],
          ),
        ),
      ),
    );

  }
}


class Users {
  String version;
  String model;
  String brands;
  String vehicle_number;
  String Service_Code;
  String sstatus;

  Users({
    this.version,
    this.model,
    this.brands,
    this.vehicle_number,
    this.Service_Code,
    this.sstatus,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      version: json['version'],
      brands: json['brands'],
      model: json['model'],
      vehicle_number: json['vehicle_number'],
      Service_Code: json['Service_Code'],
      sstatus: json['Status'],
    );
  }
}
class usr {
  String username;
  String mobile_number;
  String password;
  String earnpoints;
  String mode;


  usr({
    this.username,
    this.mobile_number,
    this.password,
    this.earnpoints,
    this.mode,
  });

  factory usr.fromJson(Map<String, dynamic> json) {
    return usr(
      username: json['username'],
      mobile_number: json['mobile_number'],
      password: json['password'],
      earnpoints: json['earnpoints'],
      mode: json['mode'],
    );
  }
}