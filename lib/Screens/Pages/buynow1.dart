import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasthu/Screens/Pages/ordersuccess.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class BuyNowCart extends StatefulWidget {
  @override
  _BuyNowCartState createState() => _BuyNowCartState();
}

class _BuyNowCartState extends State<BuyNowCart> {
  @override
  Widget build(BuildContext context) {
    final promocontroller = TextEditingController();

    ///Userid retriueving
    ///

    final FirebaseAuth auth = FirebaseAuth.instance; // taking current user id
    final User? user = auth.currentUser; // taking current user id
    final myUid = user!.uid; // taking current user id

    final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
        .instance
        .collection('cart')
        .where('cid', isEqualTo: myUid);

    CollectionReference orderReference =
        FirebaseFirestore.instance.collection('orders');
    String promocode = promocontroller.text;
    Query<Map<String, dynamic>> promoReference = FirebaseFirestore.instance
        .collection('promotions')
        .where('promocode', isEqualTo: promocode);

    

    double shipping = 150;
    double promo = 0;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 16.0,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 10),
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  "Your Items",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Flexible(
              child: StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs
                          .map(
                            (e) => Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image(
                                      image: NetworkImage(
                                        e['FileImage'],
                                      ),
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      //        mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          e['orderproduct'],
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Colors.red[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${e['price']} x ${e['qty']}",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return Center(child: Text('Empty'));
                },
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Divider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 8.0, 0),
                  child: Text(
                    "Promo Code",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextField(
                      controller: promocontroller,
                      decoration: textInputDecorforUpdate,
                      style: TextStyle(height: 0.4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
        .collection('promotions')
        .where('promocode', isEqualTo: promocode).snapshots(),
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
                          print(ds.length);

                          return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  promo = 100;
                                });
                                print(ds);
                              },
                              child: Text('Apply'));
                        } else {
                          return ElevatedButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg:
                                        "Error Code : " + promocontroller.text);
                              },
                              child: Text('Apply'));
                        }
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Divider(
              height: 10.0,
            ),
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
                        Text(
                          "Shipping Cost ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "- Promotion ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Sub Total ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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
                            }),
                        Text(
                          "$shipping",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "$promo",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
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
                              print(ds[0]['price']);
                              double sum = 0.0;
                              for (int i = 0; i < ds.length; i++) {
                                sum += (ds[i]['price']);
                                print(sum);
                              }
                              double subtotal = sum + shipping - promo;

                              return Text(
                                "$subtotal",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
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

                        double sum = 0.0;
                        String proName = "";
                        String qty = "";
                        String pid = "";
                        //  List<String> proName = [];
                        for (int i = 0; i < ds.length; i++) {
                          sum += (ds[i]['price']);
                          proName += (ds[i]['orderproduct'] + ', ');
                          qty += (ds[i]['qty'].toString() + ', ');
                          pid += (ds[i]['pid'] + ', ');
                          print(proName);
                          print(qty);
                          print(pid);
                        }
                        double subtotal = sum + shipping - promo;

                        return StreamBuilder<Object>(
                            stream: orderReference.snapshots(),
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
                              int tot = ds.length;
                              return ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance // making the order
                                      .collection('orders')
                                      .doc("order$tot")
                                      .set({
                                    "OrderId": "order$tot",
                                    "ProductName": proName,
                                    "quantity": qty,
                                    "Price": subtotal,
                                    //      "FileImage": "${data['FileImage']}",
                                    "cid": myUid,
                                    "pid": pid,
                                    "status": "pending",
                                  }).then((value) => {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderSuccess()),
                                            ),
                                          });
                                },
                                child: Text('Checkout'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.green[500],
                                  textStyle: TextStyle(fontSize: 14),
                                ),
                              );
                            });
                      }),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
