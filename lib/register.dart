import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service2go/main.dart';
import 'package:fluttertoast/fluttertoast.dart';


class register extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: RegisterUser()
          )
      ),
      routes: <String, WidgetBuilder>{
        '/loginpage': (BuildContext context) => new login(),
      },
    );
  }
}

class RegisterUser extends StatefulWidget {

  RegisterUserState createState() => RegisterUserState();

}

class RegisterUserState extends State {

  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  Future loginpage() async{

    Navigator.pushReplacementNamed(context, "/loginpage");
  }
  Future userRegistration() async{

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String name = nameController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;
    String confirmpassword = confirmpasswordController.text;

    // SERVER API URL
    var url = 'http://vnplad.com/service2go/register_user.php';

    // Store all data with Param Name.
    var data = {'name': name, 'mobile': mobile, 'password' : password, 'confirmpassword' : confirmpassword};

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
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    padding: EdgeInsets.only(left: 20.0),

                  ),
                  new SizedBox(height: 30.0,),

                  new Image.asset(
                    "assets/images/logo.png",
                    height: 150.0,
                    width: 210.0,
                    fit: BoxFit.scaleDown,
                  ),

                  Divider(),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: nameController,
                        autocorrect: true,
                        decoration: InputDecoration(labelText: 'Enter Your Name*'),
                      )
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
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: 'Enter Your Mobile Number*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Enter Your Password*'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: confirmpasswordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Confirm Password*'),
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
                        if (!(nameController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter user name.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        } else if (!(mobileController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter your Mobile Number.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        }else if (!(passwordController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter Password.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        }else if (!(confirmpasswordController.value.text
                            .trim()
                            .toString()
                            .length >
                            1)) {
                          Fluttertoast.showToast(
                              msg: "Please enter Confirm Password.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1);
                        } else if (!(confirmpasswordController.value.text == passwordController.value.text)) {
                          Fluttertoast.showToast(
                              msg: "Confirm Password not matched.",
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

                          userRegistration();



                        }
                      },
                      child: new Text(
                        "Register",
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

                  FlatButton(
                    onPressed: loginpage,
                    textColor: Colors.blue,
                    child: Text('Already Member? Login Here',
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