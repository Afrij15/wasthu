import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Profile_Pages/cart.dart';
import 'package:wasthu/Profile_Pages/notification.dart';
import 'package:wasthu/Screens/Pages/search.dart';
import 'package:wasthu/Screens/Pages/show-product.dart';
import 'package:wasthu/shared/loading.dart';

class Home extends StatelessWidget {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  final Query<Map<String, dynamic>> catecollectionReference = FirebaseFirestore
      .instance
      .collection('products')
      .where('Category', isEqualTo: "Dresses");

  @override
  Widget build(BuildContext context) {
    /*  ///Userid retriueving
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;

    final Query<Map<String, dynamic>> cartcollectionReference =
        FirebaseFirestore.instance
            .collection('cart')
            .where('cid', isEqualTo: myUid);
*/
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Search()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(),
                            Text(
                              'Search',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            primary: Colors.pink[200]),
                      ),
                    ),
                    IconButton(
                      color: Colors.pink[300],
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notifications(),
                          ),
                        );
                      },
                    ),
                    Stack(
                      children: [
                        IconButton(
                          color: Colors.pink[300],
                          icon: const Icon(Icons.shopping_bag),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                        ),
                        /*  Positioned(
                          right: 20,
                          bottom: 10,
                          child: StreamBuilder(
                              stream: cartcollectionReference.snapshots(),
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

                                  return Text(
                                    ds.length.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.limeAccent,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.limeAccent,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              }),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/Car1.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/Car2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              //Latest Arrivals Card Section
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 8.0),
                child: Text(
                  "Latest Arrivals",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.pink[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 190,
                child: StreamBuilder(
                    stream: collectionReference.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 16, right: 6),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final e = snapshot.data!.docs[index];

                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 199,
                                width: 344,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Image(
                                        image: NetworkImage(
                                          e['FileImage'],
                                        ),
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 10,
                                      child: Text(
                                        e['ProductName'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      right: 50,
                                      top: 70,
                                      child: Container(
                                        // padding: EdgeInsets.all(4.0),
                                        color: Colors.pink[300],
                                        child: IconButton(
                                          color: Colors.white,
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowProduct(e.id),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 25,
                                      bottom: 10,
                                      child: Text(
                                        e['Price'] + 'Rs',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              //    return Center(child: Text('hi'));
                            });
                      }
                      return Loading();
                    }),
              ),
              //Top Trending Card Section
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 8.0),
                child: Text(
                  " Fashion ",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.pink[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 190,
                child: StreamBuilder(
                    stream: catecollectionReference.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 16, right: 6),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final e = snapshot.data!.docs[index];

                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 199,
                                width: 344,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Image(
                                        image: NetworkImage(
                                          e['FileImage'],
                                        ),
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 10,
                                      child: Text(
                                        e['ProductName'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      right: 50,
                                      top: 70,
                                      child: Container(
                                        // padding: EdgeInsets.all(4.0),
                                        color: Colors.pink[300],
                                        child: IconButton(
                                          color: Colors.white,
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowProduct(e.id),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 25,
                                      bottom: 10,
                                      child: Text(
                                        e['Price'] + 'Rs',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              //    return Center(child: Text('hi'));
                            });
                      }
                      return Loading();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderCard(String name, String price, String image) {
    return Card(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/Car1.jpeg'),
            width: double.infinity,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Calvin Frock',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Rs.4500',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
