import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/shared/loading.dart';

class Promotion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final myUid = user!.uid;

final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
    .instance
    .collection('promotions')
    .where('for', isEqualTo: "all");
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text('Promotions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['promotion']),
                subtitle: Text(data['amount']),
                leading: Icon(Icons.local_offer),
                onTap: () {},
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
