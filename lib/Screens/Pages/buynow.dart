import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/ordersuccess.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class BuyNow extends StatefulWidget {
  final String documentId;
  final int quantity;

  BuyNow(this.documentId, this.quantity);

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  @override
  Widget build(BuildContext context) {
    TextEditingController promocontroller = TextEditingController();

    ///Userid retriueving

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;
    CollectionReference users =
        FirebaseFirestore.instance.collection('products');

       CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('orders');

  

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          TextEditingController addresscontroller =
              TextEditingController();
         
          int price = int.parse(data['Price']);
          int total = price * widget.quantity;
          int shippingprice = 150;
          int promotion = 0;
             String promocode = " ";
          int subtotal = total + shippingprice - promotion;
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                /*  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[300],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green[700],
                          ),
                          TextField(
                            controller: addresscontroller,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Divider(),*/
                   SizedBox(
                    height: 8.0,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image(
                          image: NetworkImage(
                            "${data['FileImage']}",
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
                              "${data['ProductName']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${data['Price']} x ${widget.quantity}",
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
                          child: TextFormField(
                           
                            decoration: textInputDecorforUpdate,
                            validator: (val) =>
                                      val!.isEmpty ? 'Enter an Email' : null,
                                
                                  onChanged: (val) {
                                    setState(() => promocode = val);
                                  },
                            style: TextStyle(height: 0.4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: ElevatedButton(
                          onPressed: () {
                          
                          },
                          child: Text('Apply'),
                        ),
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
                              Text(
                                "$total",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "$shippingprice",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "$promotion",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "$subtotal",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder(
                        stream:  collectionReference.snapshots(),
                        builder: (context, snapshot) {
                           if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text("Something went wrong");
                }

                           dynamic ds1 = snapshot.data;
                var ds = ds1.docs;
                int tot = ds.length;
                          return Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc("order$tot")
                                    .set({
                                  "OrderId": "order$tot",
                                  "ProductName": "${data['ProductName']}",
                                  "quantity": widget.quantity,
                                  "Price": subtotal,
                                  "FileImage": "${data['FileImage']}",
                                     "status": "pending",
                                  "cid": myUid,
                                  
                             
                                  
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
                            ),
                          ));
                        }
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }

        return Loading();
      },
      
    );
  }
  
}
