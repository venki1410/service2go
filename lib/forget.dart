import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';


class forget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: forgetUser()
          )
      ),
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => new login(),
      },
    );
  }
}

class forgetUser extends StatefulWidget {

  forgetUserState createState() => forgetUserState();

}

class forgetUserState extends State {

  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  // Getting value from TextField widget.
  final mobileController = TextEditingController();
  Future forgetRegistration() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String mobile = mobileController.text;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/forget.php';

    // Store all data with Param Name.
    var data = {'mobile': mobile};


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

    if(message=='sucess'){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('phone', mobile);
      Navigator.push(context, new MaterialPageRoute(builder: (context) =>otpPage() ));
    }else{
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),

                  ),
                  new SizedBox(height: 30.0,),


                  Divider(),



                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: mobileController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Enter Your Mobile Number*'),
                      )
                  ),


                  new Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, top: 17.0, bottom: 5.0),
                    child: new RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (!(mobileController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter your Mobile Number.",
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

                          forgetRegistration();



                        }
                      },
                      child: new Text(
                        "VERIFY",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xFF54C5F8),
                      textColor: Colors.white,
                      elevation: 5.0,
                      padding: EdgeInsets.only(
                          left: 80.0,
                          right: 80.0,
                          top: 15.0,
                          bottom: 15.0),
                    ),
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


//otpTextField

class otp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Credit Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: otpPage(),
    );
  }
}

class otpPage extends StatefulWidget {
  otpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _otpPageState createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {

  Future validateOtp(pin) async{

    var url = 'http://vnplad.com/service2go/otp_validate.php';
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    // Store all data with Param Name.
    var data = {'pin': pin,'mobile':phone};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    if(message=="verified"){

      Navigator.push(context, new MaterialPageRoute(builder: (context) =>changePassword() ));


    }else{
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


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OTPTextField(
          length: 4,
          width: MediaQuery.of(context).size.width,
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldWidth: 50,
          fieldStyle: FieldStyle.underline,
          style: TextStyle(
              fontSize: 17
          ),
          onCompleted: (pin) {
            print("Completed: " + pin);
            validateOtp(pin);

          },
        ),
      ),
    );
  }
}

class changePassword extends StatefulWidget {
  changePasswordState createState() => changePasswordState();

}

class changePasswordState extends State<changePassword> {
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  Future updatePassword() async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var phone = preferences.getString('phone');
    String pass = passwordController2.text;

    var url = 'http://vnplad.com/service2go/update_password.php';

    // Store all data with Param Name.
    var data = {'mobile':phone,'password':pass};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    if(message=="updated"){
      Navigator.pushReplacementNamed(context, "/login");
    }
    else{
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),

                  ),
                  new SizedBox(height: 30.0,),


                  Divider(),



                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController1,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Enter New Password*'),
                      )
                  ),


                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController2,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        autocorrect: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Enter Password Again*'),
                      )
                  ),


                  new Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, top: 17.0, bottom: 5.0),
                      child: new RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(30.0)),
                          onPressed: () {
                            String p1 = passwordController1.value.text;
                            String p2 = passwordController2.value.text;
                            if (p1 != p2) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Password Mismatch"),
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
                            } else if (passwordController1.value.text ==
                                passwordController2.value.text) {
                              updatePassword();
                            }
                          }
                      )

                  ),
                  Text(
                    "VERIFY",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold),
                  ),



                  Visibility(
                    //visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          //child: CircularProgressIndicator()
                      )
                  ),

                ],
              ),
            )));
  }
}