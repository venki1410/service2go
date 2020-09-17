import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';
import 'package:service2go/referfriends.dart';
import 'package:service2go/todayoffers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listpages extends StatelessWidget {

  String value;
  listpages({this.value});



  @override
  Widget build(BuildContext context) {

    Future LogOut()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('mobile');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>login()),);
    }

    Future profile()async{
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) =>usrs() ));
    }



    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
              child: listpage()
          ),



        ) );


  }


}




class listpage extends StatefulWidget {

  listpageState createState() => listpageState();

}


class listpageState extends State {
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;
  Widget _page3;

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _page1 = homepages();
    _page2 = usrs();

    _pages = [_page1, _page2];

    _currentIndex = 0;
    _currentPage = _page1;
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changeTab(index),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.orange,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),

            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            )
          ]),
    );
  }

  Widget navigationItemListTitle(String title, int index) {
    return new ListTile(
      title: new Text(
        title,
        style: new TextStyle(color: Colors.amber, fontSize: 22.0),
      ),
      onTap: () {
        Navigator.pop(context);
        changeTab(index);
      },
    );
  }
}


class homepages extends StatelessWidget {

  String value;
  homepages({this.value});



  @override
  Widget build(BuildContext context) {

    Future LogOut()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('mobile');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>login()),);
    }

    Future profile()async{
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) =>usrs() ));
    }



    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

          appBar: AppBar(backgroundColor: Colors.amber,title: Text('Service2Go',style: TextStyle(color: Colors.black)),
            actions: <Widget>[


              IconButton( icon:   Icon(Icons.input,color: Colors.black),
                  onPressed: () {
                    LogOut();

                  })

            ],
          ),
          body: Center(
              child: homepage()
          ),



        ) );


  }


}



class Userssprofile {
  String brand;
  String model;
  String version;
  String bike_no;

  Userssprofile({
    this.brand,
    this.model,
    this.version,
    this.bike_no,
  });

  factory Userssprofile.fromJson(Map<String, dynamic> json) {
    return Userssprofile(
      brand: json['brand_name'],
      version: json['version_no'],
      model: json['model_name'],
      bike_no: json['bike_number'],
    );
  }
}
class homepage extends StatefulWidget {

  homepagesState createState() => homepagesState();

}


class homepagesState extends State {
  List<String> items;
  String mobile ="";

  Future getMobile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mobile = preferences.getString('mobile');

    });
  }
  String url ='http://www.vnplad.com/service2go/usr.php/';


  Future<List<usr>> _fetchusr() async {
    final String uri = url + mobile;
    print(uri);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<usr> listOfusr = items.map<usr>((json) {
        return usr.fromJson(json);
      }).toList();

      return listOfusr;
    } else {
      throw Exception('Failed to load internet');
    }
  }



  @override
  void initState() {
    getMobile();
    _fetchusr();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body:  SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[

                  new Image.asset(
                    "assets/images/bikeservice.png",

                    fit: BoxFit.scaleDown,
                  ),

                  Row(
                    children: [
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*2*/
                            Container(
                              color: Colors.grey[350],
                              padding: const EdgeInsets.only(bottom: 40, top: 40),
                              child:Center(
                                child: Text('No Offer Found!',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*3*/
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        /*1*/
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*2*/
                            Container(
                              padding: EdgeInsets.all(16.0),

                              child: Row(children: <Widget>[

                                FlatButton(
                                  onPressed: (){ Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) =>Bookservice() ));},
                                  textColor: Colors.black,

                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.date_range, size: 50),
                                      Text('Book Service'),
                                    ],

                                  ),

                                ),
                                Padding(padding:const EdgeInsets.all(16.0)),
                                Container(height: 80, child: VerticalDivider(color: Colors.black)),
                                Padding(padding:const EdgeInsets.all(16.0)),
                                FlatButton(
                                  onPressed: (){ Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) =>referfriends() ));},
                                  textColor: Colors.black,
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.person_add, size: 50),
                                      Text('Refer Friend'),

                                    ],

                                  ),

                                ),

                              ],
                              ),

                            ),
                            Container( child: Divider(color: Colors.black,indent: 20,endIndent: 20,)),
                            Container(
                              padding: EdgeInsets.all(16.0),

                              child: Row(children: <Widget>[

                                FlatButton(
                                  onPressed: (){ Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) =>myvehicle() ));},
                                  textColor: Colors.black,

                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.motorcycle, size: 50),
                                      Text('  My Vehicle  '),
                                    ],

                                  ),

                                ),
                                Padding(padding:const EdgeInsets.all(16.0)),
                                Container(height: 80, child: VerticalDivider(color: Colors.black)),
                                Padding(padding:const EdgeInsets.all(16.0)),
                                FlatButton(
                                  onPressed: (){ Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) =>Servicehistory() ));},
                                  textColor: Colors.black,
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.assignment, size: 50),
                                      Text('My Service'),

                                    ],

                                  ),

                                ),

                              ],
                              ),

                            ),

                          ],
                        ),
                      ),
                      /*3*/
                    ],
                  ),







                ],
              ),
            )));
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
    // TODO: implement build
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
                                    color: Colors.orange,
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
                                    color: Colors.orange,
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


// <!------------------------------------ Book Service Page ------------------------------------------------------------> //

class Bookservice extends StatelessWidget {
  String value;
  Bookservice({this.value});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title:Center( child: Text('Service2Go')),
            automaticallyImplyLeading: true,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
          ),

          body: Center(
              child: RegisterUser()
          )
      ),

    );
  }

}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}

class RegisterUser extends StatefulWidget {

  RegisterUserState createState() => RegisterUserState();

}

class RegisterUserState extends State {

  String _date = "Set Date";
  String _time = "Set Time";
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  bool visit = false;

  bool pickup = false;
  String t = "false";
  String vt = "false";

  void toggleCheckbox(bool value) {

  }

  // Getting value from TextField widget.
  final modelController = TextEditingController();
  final versionController = TextEditingController();
  final vnumberController = TextEditingController();
  final addressController = TextEditingController();


  Future bookserviceregister() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String model = modelController.text;
    String version = versionController.text;
    String vnumber = vnumberController.text;
    String address = addressController.text;
    String visit = vt;
    String pickup = t;
    String Brands = _selectedText;
    String SetTime = _time;
    String Setdate = _date;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/bookvehicle.php/${value}';

    // Store all data with Param Name.
    var data = {
      'name': model,
      'mobile': version,
      'password': vnumber,
      'confirmpassword': address,
      'visit': visit,
      'pickup': pickup,
      'brands': Brands,
      'date' : Setdate,
      'time' : SetTime,
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
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) =>Servicehistory() ));
  }

  String _selectedText = null;
  String _selectedTextmodel = null;

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
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.amber,
                      child:Center( child : Text('Book your vehicle for Service',
                          style: TextStyle(fontSize: 21,
                              color:Colors.white)))),

                  Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: new DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Select Model"),
                      value: _selectedText,
                      items: <String>[ 'HERO', 'TVS', 'HONDA', 'YAMAHA', 'SUZUKI']
                          .map((String value) {
                        return new DropdownMenuItem<String>(

                          value: value,
                          child: new Text(value,
                              style: TextStyle(
                                fontSize: 13.0,
                              )),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        _selectedText = val;
                        setState(() {
                          _selectedText = val;
                        });

                      },
                    ),
                  ),



                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: versionController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Vehicle Version*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: modelController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        decoration: InputDecoration(
                            labelText: 'Vehicle model*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: vnumberController,
                        autocorrect: true,
                        decoration: InputDecoration(
                            labelText: 'Vehicle Number*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: addressController,
                        autocorrect: true,
                        decoration: InputDecoration(labelText: 'Address*'),
                      )
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(10.0),
                          onPressed: ()  {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(2020, 1, 1),
                                maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                                  print('confirm $date');
                                  _date = '${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },

                          child: Text(
                            " $_date",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),

                        FlatButton(
                          onPressed: ()  {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                                  print('confirm $time');
                                  _time = '${time.hour} : ${time.minute}';
                                  setState(() {});
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                            setState(() {});
                          },

                          child: Text(
                            " $_time",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ]),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Visit"),
                            new Checkbox(
                              value: visit,
                              onChanged: (bool e) => somethings(),
                              activeColor: Colors.amber,
                              checkColor: Colors.white,
                              tristate: false,
                            ),

                          ]
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Pickup & Drop"),
                            Checkbox(
                              value: pickup,
                              onChanged: (bool e) => something(),
                              activeColor: Colors.amber,
                              checkColor: Colors.white,
                              tristate: false,
                            ),


                          ]
                      ),
                    ],
                  ),
                  Divider(),
                  RaisedButton(
                    onPressed: bookserviceregister,
                    color: Colors.amber,
                    textColor: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.only(
                        left: 80.0,
                        right: 80.0,
                        top: 15.0,
                        bottom: 15.0),
                    child: Text('Book Now'),
                  ),


                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),

                ],
              ),
            )));
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

  void somethings() {
    setState(() {
      if (visit) {
        vt = "false";
        visit = !visit;
      } else {
        vt = "true";
        visit = !visit;
      }
    });
  }
}
//<!------------------------------------------ Add vehicle ---------------------------------------------------------> //
class addvehicle extends StatelessWidget {
  String value;
  addvehicle({this.value});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text('Service2Go'),
            automaticallyImplyLeading: true,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
          ),

          body: Center(
              child: RegisterUsers()
          )
      ),

    );
  }

}
class Items {
  const Items(this.name,this.icon);
  final String name;
  final Icon icon;
}

class RegisterUsers extends StatefulWidget {

  RegisterUserStates createState() => RegisterUserStates();

}

class RegisterUserStates extends State {

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  bool visit = false;

  bool pickup = false;
  String t = "false";
  String vt = "false";

  void toggleCheckbox(bool value) {

  }

  // Getting value from TextField widget.
  final modelnameController = TextEditingController();
  final versionnoController = TextEditingController();
  final bikenumberController = TextEditingController();
  final useraddressController = TextEditingController();


  Future addvehicleregister() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String model_name = modelnameController.text;
    String version_no = versionnoController.text;
    String bike_number = bikenumberController.text;
    String user_address = useraddressController.text;
    String Brand_name = _selectedbrand;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/addvehicle.php/${value}';

    // Store all data with Param Name.
    var data = {
      'model_name': model_name,
      'version_no': version_no,
      'bike_number': bike_number,
      'user_address': user_address,
      'brand_name': Brand_name,
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
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) =>Servicehistory() ));
  }

  String _selectedbrand = null;
  String _selectedTextmodel = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Add your vehicle',
                          style: TextStyle(fontSize: 21))),

                  Divider(),

                  Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: new DropdownButton<String>(
                      isExpanded: true,
                      hint: Text("Select Brand"),
                      value: _selectedbrand,
                      items: <String>[ 'HERO', 'TVS', 'HONDA', 'YAMAHA', 'SUZUKI']
                          .map((String value) {
                        return new DropdownMenuItem<String>(

                          value: value,
                          child: new Text(value,
                              style: TextStyle(
                                fontSize: 13.0,
                              )),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        _selectedbrand = val;
                        setState(() {
                          _selectedbrand = val;
                        });

                      },
                    ),
                  ),



                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: versionnoController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Vehicle Version*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: modelnameController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        decoration: InputDecoration(
                            labelText: 'Vehicle model*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: bikenumberController,
                        autocorrect: true,
                        decoration: InputDecoration(
                            labelText: 'Vehicle Number*'),
                      )
                  ),

                  RaisedButton(
                    onPressed: addvehicleregister,
                    color: Colors.amber,
                    textColor: Colors.white,
                    elevation: 5.0,
                    padding: EdgeInsets.only(
                        left: 80.0,
                        right: 80.0,
                        top: 15.0,
                        bottom: 15.0),
                    child: Text('Add Vehicle'),
                  ),


                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),

                ],
              ),
            )));
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

  void somethings() {
    setState(() {
      if (visit) {
        vt = "false";
        visit = !visit;
      } else {
        vt = "true";
        visit = !visit;
      }
    });
  }
}

// <!------------------------------------------ Refer Friends -------------------------------------------------------> //

class referfriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: referfriendss()
          )
      ),

    );
  }
}

class referfriendss extends StatefulWidget {

  referfriendsState createState() => referfriendsState();

}

class referfriendsState extends State {
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
                    onPressed: (){ Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>Bookservice() ));},
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

// <!----------------------------------------- My Rewards --------------------------------------------> //
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

class myrewards extends StatelessWidget {
  String value;
  myrewards({this.value});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: myrewardss()
          )
      ),
    );
  }
}

class myrewardss extends StatefulWidget {

  myrewardsState createState() => myrewardsState();

}

class myrewardsState extends State {

  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
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
                      child: Text("My Rewards",
                          style: TextStyle(fontSize: 21))),
                  Divider(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total Earnings"),
                        Container(
                          width: 280,
                          padding: EdgeInsets.all(10.0),
                          child: FutureBuilder<Album>(
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
                    onPressed: (){ Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>redeempage() ));},
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Reedem'),
                  ),





                ],
              ),
            )));
  }



}

// <!-------------------------------- Redeem page ---------------------------------------> //

class redeempage extends StatelessWidget {

  String value;
  redeempage({this.value});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: redeempages()
          )
      ),
    );
  }
}

class redeempages extends StatefulWidget {

  redeempageState createState() => redeempageState();

}

class redeempageState extends State {
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
                    onPressed: (){ Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>reedempoints() ));},
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Reedem For Service'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                  ),
                  RaisedButton(
                    onPressed: (){ Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>referfriends() ));},
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

// <!------------------------------------------ Redeem Points --------------------------------------------> //

Future<Albums> fetchAlbums() async {
  final response =
  await http.get('http://vnplad.com/service2go/fetch_points.php/${value}',  headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonresponse = json.decode(response.body);
    return Albums.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an excep tion.
    throw Exception('Failed to load album');
  }
}

class Albums {
  final earnpoints;

  Albums({  this.earnpoints});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
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
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: reedempointss()
          )
      ),
    );
  }
}

class reedempointss extends StatefulWidget {

  reedempointsState createState() => reedempointsState();

}

class reedempointsState extends State {

  Future<Albums> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();

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
                          child:FutureBuilder<Albums>(
                            future: futureAlbums,
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
                    onPressed: (){ Navigator.push(context,
                        new MaterialPageRoute(builder: (context) =>Bookservice() ));},
                    color: Colors.amber,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text('Burn'),
                  ),





                ],
              ),
            )));
  }



}


Future<Albums> fetchservice() async {
  final response =
  await http.get('http://vnplad.com/service2go/fetch_points.php/${value}',  headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonresponse = json.decode(response.body);
    return Albums.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class serviceAlbums {
  final earnpoints;

  serviceAlbums({  this.earnpoints});

  factory serviceAlbums.fromJson(Map<String, dynamic> json) {
    return serviceAlbums(
      earnpoints: json['earnpoints'],

    );
  }

}

// <!----------------------------------------------- Service History --------------------------------------------------->

class Servicehistory extends StatelessWidget {

  String value;
  Servicehistory({this.value});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: Servicehistorys()
          )
      ),
    );
  }
}

class Servicehistorys extends StatefulWidget {

  ServicehistoryState createState() => ServicehistoryState();

}

class ServicehistoryState extends State {
  final String uri = 'http://www.vnplad.com/service2go/servicehistory.php/${value}';

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

  Users({
    this.version,
    this.model,
    this.brands,
    this.vehicle_number,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      version: json['version'],
      brands: json['brands'],
      model: json['model'],
      vehicle_number: json['vehicle_number'],
    );
  }
}

//<!--------------------------------------------------- My Vehicle ------------------------------------------------------->

class myvehicle extends StatelessWidget {

  String value;
  myvehicle({this.value});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(backgroundColor: Colors.amber,
              title: Text('Service2Go')),
          body: Center(
              child: myvehicles()
          )
      ),
    );
  }
}

class myvehicles extends StatefulWidget {

  myvehicleState createState() => myvehicleState();

}

class myvehicleState extends State {

  final String uri = 'http://www.vnplad.com/service2go/myvehicle.php/${value}';

  Future<List<Userss>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Userss> listOfUsers = items.map<Userss>((json) {
        return Userss.fromJson(json);
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
                      Stack(
                          children: <Widget>[
                            new Image.asset(
                              "assets/images/bikeservice.png",
                              fit: BoxFit.scaleDown,
                            ),
                            Positioned(
                                right:8.0,
                                bottom: 10.0,
                                child:FloatingActionButton.extended(
                                  icon: Icon(Icons.add_circle),
                                  onPressed: (){Navigator.push(context,
                                      new MaterialPageRoute(builder: (context) =>addvehicle() ));},
                                  label: Text('Add Bike'),
                                )
                            )
                          ]
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(5.0),
                          color: Colors.amber,
                          child:Center( child : Text('My Vehicle',
                              style: TextStyle(fontSize: 21,
                                  color:Colors.white)))),
                      Padding(padding:const EdgeInsets.all(16.0)),
                      Container(
                        color: Colors.grey[50],
                        child:Row(children: <Widget>[

                          FlatButton(
                            onPressed: (){ Navigator.push(context,
                                new MaterialPageRoute(builder: (context) =>Bookservice() ));},
                            textColor: Colors.black,

                            child: Column(
                              children: <Widget>[
                                Icon(Icons.date_range),
                                Text('Book Service'),
                              ],

                            ),

                          ),
                          Padding(padding:const EdgeInsets.all(16.0)),
                          Container(height: 80, child: VerticalDivider(color: Colors.grey[400])),
                          Padding(padding:const EdgeInsets.all(16.0)),
                          FlatButton(
                            onPressed: (){ Navigator.push(context,
                                new MaterialPageRoute(builder: (context) =>Servicehistory() ));},
                            textColor: Colors.black,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.description),
                                Text('Service History'),

                              ],

                            ),

                          ),

                        ],
                        ),
                      ),
                      Padding(padding:const EdgeInsets.all(16.0)),
                      Container(
                        child: FutureBuilder<List<Userss>>(
                          future: _fetchUsers(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                            return ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map((user) => Card( child: ListTile(
                                title: Text("\nBrand Name\t\t:\t\t"+user.brand+"\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                subtitle: Text("Model Name\t\t\t:\t\t"+user.model+"\n\nBike Number\t\t\t:\t\t"+user.bike_no+"\n"),
                              )
                              ))
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}

class Userss {
  String brand;
  String model;
  String version;
  String bike_no;

  Userss({
    this.brand,
    this.model,
    this.version,
    this.bike_no,
  });

  factory Userss.fromJson(Map<String, dynamic> json) {
    return Userss(
      brand: json['brand_name'],
      version: json['version_no'],
      model: json['model_name'],
      bike_no: json['bike_number'],
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