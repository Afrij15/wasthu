import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasthu/Services/auth.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bgimage.png'), fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      //margin: const EdgeInsets.only(top: 100),
                      width: double.infinity,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Reset Password",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                TextFormField(
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter an Email' : null,
                                  decoration: textInputDecorforAuth.copyWith(
                                      hintText: 'Email'),
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange[900],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic res =
                                          _auth.sendPasswordResetEmail(
                                        email: email,
                                      );
                                      if (res.code == FirebaseAuthException) {
                                        if (res.message != null) {
                                          setState(() {
                                            error = res.message;
                                          });
                                          print("erro " + error);
                                        } else {
                                          setState(() {
                                            error = "Unknown Error";
                                          });
                                          print(error);
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Send Request',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),

                                /*    TextButton(
                                  onPressed: () {
                                
                                  },
                                  child: Text(
                                    "Don't Have an Account? Sign Up",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),*/
                                SizedBox(
                                  height: 8.0,
                                ),
                                Image.asset(
                                  'assets/logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
