import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pwd = "";
  String error = "";
  bool isLoading = false;

  Future<void> makeRequest() async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _auth.signIn(email, pwd);
      if (result == null) {
        setState(() {
          error = "Please, enter valid data";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 50.0,
            vertical: 20.0,
          ),
          child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: inputDectation.copyWith(
                        labelText: "Email",
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Enter valid email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: inputDectation.copyWith(
                        labelText: "Password",
                      ),
                      validator: (val) =>
                          val.length < 6 ? "Atleast 6 caractors long" : null,
                      onChanged: (val) {
                        setState(() {
                          pwd = val;
                        });
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await makeRequest();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                        color: Colors.pink[400],
                        child: isLoading
                            ? Container(
                                width: 20.0,
                                child: (SpinKitRotatingCircle(
                                  color: Colors.white,
                                  size: 12.0,
                                )),
                              )
                            : (Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
