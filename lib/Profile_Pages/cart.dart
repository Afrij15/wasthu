import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasthu/Screens/Pages/buynow1.dart';
import 'package:wasthu/Screens/Pages/show-product.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Userid retriueving
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;

    final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
        .instance
        .collection('cart')
        .where('cid', isEqualTo: myUid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: collectionReference.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.docs
                        .map((e) => ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShowProduct(e['pid']),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      e['FileImage'],
                                    ),
                                  ),
                                  title: Text(
                                    e['orderproduct'],
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  subtitle: Text(
                                    e['price'].toString(),
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  /* trailing: Text(
                                e['Status'],
                                style: TextStyle(color: Colors.green),
                              ),*/
                                  trailing: IconButton(
                                    color: Colors.red,
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(e.id)
                                          .delete()
                                          .then((value) =>
                                              Fluttertoast.showToast(
                                                  msg: 'Deleted'));
                                    },
                                  ),
                                )
                            /*Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowProduct(e['pid']),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  e['FileImage'],
                                ),
                              ),
                              title: Text(
                                e['orderproduct'],
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              subtitle: Text(
                                e['price'],
                                style: TextStyle(color: Colors.black54),
                              ),
                              /* trailing: Text(
                                e['Status'],
                                style: TextStyle(color: Colors.green),
                              ),*/
                              trailing: IconButton(
                                color: Colors.red,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(e.id)
                                      .delete()
                                      .then((value) =>
                                          Fluttertoast.showToast(msg: 'Deleted'));
                                },
                              ),
                              isThreeLine: true,
                            ),
                          ),*/
                            )
                        .toList(),
                  );
                }
                return Center(child: Text('Empty'));
              },
            ),
          ),
          StreamBuilder(
              stream: collectionReference.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text("Something went wrong");
                }

                dynamic ds1 = snapshot.data;

                var ds = ds1.docs;
                if (ds.length > 0) {
                  print(ds[0]['price']);
                  double sum = 0.0;
                  for (int i = 0; i < ds.length; i++) {
                    sum += (ds[i]['price']);
                    print(sum);
                  }

                  return FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyNowCart(),
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_right_alt));
                } else {
                  return FloatingActionButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Cart is empty');
                      },
                      child: Icon(Icons.arrow_right_alt));
                }
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[300],
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total ",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StreamBuilder(
                          stream: collectionReference.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (!snapshot.hasData) {
                              return Text("Something went wrong");
                            }

                            dynamic ds1 = snapshot.data;

                            var ds = ds1.docs;
                            if (ds.length > 0) {
                              print(ds[0]['price']);
                              double sum = 0.0;
                              for (int i = 0; i < ds.length; i++) {
                                sum += (ds[i]['price']);
                                print(sum);
                              }

                              return Text(
                                "$sum",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              );
                            } else {
                              return Text(
                                "0",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              );
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
        ],
      ),
    );
  }
}

void delete(BuildContext context) {
  /*  FirebaseFirestore.instance
                                .collection('cart')
                                .doc(e.id)
                                .delete()
                                .then((value) =>
                                    Fluttertoast.showToast(msg: 'Deleted'));*/
}
