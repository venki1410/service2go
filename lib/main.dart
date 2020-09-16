import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service2go/listpage.dart';
import 'package:service2go/register.dart';
import 'package:service2go/admin.dart';
import 'package:service2go/forget.dart';
import 'package:service2go/service_accept.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var mobile = preferences.getString('mobile');
  runApp(MaterialApp(
    home: mobile == null ? login() : listpages(),
  ));
}

String value;

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: loginuser()
          )
      ),
      routes: <String, WidgetBuilder>{
        '/registerpage': (BuildContext context) => new register(),
        '/listpage': (BuildContext context) => new listpages(value:value),
        '/service_accept': (BuildContext context) => new service_accept(),
        '/admin': (BuildContext context) => new admin(),
        '/forget': (BuildContext context) => new forget(),
        '/login': (BuildContext context) => new login(),
      },
    );
  }
}



class loginuser extends StatefulWidget {

  loginuserState createState() => loginuserState();

}

class loginuserState extends State {

  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  // Getting value from TextField widget.
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  Future loginuser() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String mobile = mobileController.text;
    String password = passwordController.text;


    // SERVER API URL
    var url = 'http://vnplad.com/service2go/login_user.php';

    // Store all data with Param Name.
     var data = { 'mobile': mobile, 'password' : password, };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
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
    if(message == 'Login Successfull') {
      Navigator.pushReplacementNamed(context, "/listpage");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('mobile', mobileController.text);
    }
    else if(message == 'Welcome Admin'){
      Navigator.pushReplacementNamed(context, "/admin");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('mobile', mobileController.text);
    }
    else if(message == 'Not Exists'){
      Navigator.push(context,new MaterialPageRoute(builder: (context) =>login() ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 50.0),

                  ),
                  new SizedBox(height: 30.0,),

                  new Image.asset(
                    "assets/images/logo.png",
                    height: 150.0,
                    width: 210.0,
                    fit: BoxFit.scaleDown,
                  ),

                  Divider(),

                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),

                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: mobileController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Mobile Number*",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.amber,
                          ),),
                        onChanged: (text){
                          value = text;
                        },
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password*",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.amber,
                          ),),
                      )
                  ),


                  new Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, top: 20.0, bottom: 20.0),
                    child: new RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (!(mobileController.value.text
                            .trim()
                            .toString()
                            .length >
                            9)) {
                          Fluttertoast.showToast(
                              msg: "Please enter Mobile Number.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        } else if (!(passwordController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter the Password.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        } else {


                          /* Fluttertoast.showToast(
                                              msg:
                                              "You have successfull logedin to " +
                                                  email_controller.value.text
                                                      .toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIos: 1);
*/
                          // email_controller.clear();
                          //password_controller.clear();
                          //Navigator.of(context).pop(LOGIN_SCREEN);

                          loginuser();



                        }
                      },
                      child: new Text(
                        "Login",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.amber,
                      textColor: Colors.black,
                      elevation: 5.0,
                      padding: EdgeInsets.only(
                          left: 80.0,
                          right: 80.0,
                          top: 15.0,
                          bottom: 15.0),
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                      Navigator.pushReplacementNamed(context, "/forget");
                    },
                    textColor: Colors.black54,
                    child: Text('Forgot Password'),
                    padding: EdgeInsets.only(
                        left: 80.0,
                        right: 80.0,
                        top: 15.0,
                        bottom: 15.0),
                  ),

                  FlatButton(
                    onPressed: (){
                      //forgot password screen
                      Navigator.pushReplacementNamed(context, "/registerpage");
                    },
                    textColor: Colors.black54,
                    child: Text('New member? Register Here',
                      style: TextStyle(
                          decoration:
                          TextDecoration.underline,
                          fontSize: 15.0),),
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
}
