import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class Settingss extends StatefulWidget {
  final String documentId;

  Settingss(this.documentId);

  @override
  _SettingssState createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {
  @override
  Widget build(BuildContext context) {
  
final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;
   final Query<Map<String, dynamic>> users = FirebaseFirestore
        .instance
        .collection('customer')
        .where('cid', isEqualTo: myUid);
        

          return StreamBuilder<Object>(
            stream: users.snapshots(),
            builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text("Something went wrong");
                }

                 dynamic ds1 = snapshot.data;

                var ds = ds1.docs;
                  final user = ds[0].data()!;
                String name = user['name'];
          String email = user['email'];
          String address = user['address'];
          String phone = user['phone'];
          TextEditingController namecontroller =
              TextEditingController(text: name);
          TextEditingController emailcontroller =
              TextEditingController(text: email);
          TextEditingController addresscontroller =
              TextEditingController(text: address);
          TextEditingController phonecontroller =
              TextEditingController(text: phone);
              return Scaffold(
                appBar: AppBar(
                  title: Text('User Info'),
                  backgroundColor: Colors.pink[400],
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a Name' : null,
                            decoration: textInputDecorforUpdate.copyWith(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.blue)),
                            controller: namecontroller,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            enabled: false,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a Name' : null,
                            decoration: textInputDecorforUpdate.copyWith(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.blue)),
                            controller: emailcontroller,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a Name' : null,
                            decoration: textInputDecorforUpdate.copyWith(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                  color: Colors.blue,
                                )),
                            controller: addresscontroller,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a Name' : null,
                            decoration: textInputDecorforUpdate.copyWith(
                                labelText: 'Phone',
                                labelStyle: TextStyle(color: Colors.blue)),
                            controller: phonecontroller,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[200],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              textStyle: TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              setState(() {
                                name = namecontroller.text;
                                email = emailcontroller.text;
                                address = addresscontroller.text;
                                phone = phonecontroller.text;
                              });
                              FirebaseFirestore.instance
                                  .collection('customer')
                                  .doc(widget.documentId)
                                  .update({
                                "name": name,
                                "email": email,
                                "address": address,
                                "phone": phone,
                              });
                            },
                            child: Text('Update'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        }

     
  }

