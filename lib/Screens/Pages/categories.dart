import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/show-search-categ.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Dresses')),
                );
              },
              child: category("Womens", "assets/item1.png"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Shoes')),
                );
              },
              child: category("Shoe", "assets/shoe.png"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ShowSearchCateg('Jewelry & accessories')),
                );
              },
              child: category("Jewellery", "assets/jewelery.jpg"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Bags')),
                );
              },
              child: category("Bag", "assets/bag.jpg"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Sunglass')),
                );
              },
              child: category("Sunglass", "assets/sunglasss.jpg"),
            ),
            /*   GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Hand Bag')),
                );
              },
              child: category("Hand Bag", "assets/handbaggg.jpg"),
            ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Bottom')),
                );
              },
              child: category("Bottom", "assets/bottom.jpg"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('Dresses')),
                );
              },
              child: category("Tshirt", "assets/tshirt.jpg"),
            ),
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSearchCateg('baths')),
                );
              },
              child: category("Baths", "assets/towel.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}

category(String type, String img) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
    child: Container(
        //     padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Container(
          child: Center(
            child: Text(
              type,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            //   color: const Color(0xff7c94b6),
            color: Colors.grey[800],
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage(
                img,
              ),
            ),
          ),
        )),
  );
}
