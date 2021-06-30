import 'package:flutter/material.dart';
import 'package:vector_cg/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vector_cg/shared/loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({required this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field
  String email = "";
  String password = "";
  bool hidePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              top: false,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 190,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val!.contains("@") && val.contains(".")
                                      ? null
                                      : "Enter an email",
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(
                              height: 42,
                            ),
                            TextFormField(
                              validator: (val) => val!.length < 8
                                  ? "Password must have minimum 8 characters"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    icon: Icon(Icons.password_sharp)),
                                border: UnderlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                            SizedBox(
                              height: 64,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 48,
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    dynamic result =
                                        await _auth.loginWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        isLoading = false;
                                        Alert(
                                                context: context,
                                                title: "Error",
                                                desc:
                                                    "Please Enter Valid Credentials!")
                                            .show();
                                      });
                                    }
                                  }
                                },
                                child: Text("LOGIN"),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF72BF44))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
                              padding: EdgeInsets.only(bottom: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "______________________________",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 48,
                              child: TextButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text("SIGN UP"),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
