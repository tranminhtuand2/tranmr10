import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_cart.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_gasdrink.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_heathy.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_milktea.dart';
import 'package:coffemanger/nhanvien/pagenhanvien.dart';
import 'package:coffemanger/userscreen/cartview.dart';
import 'package:coffemanger/userscreen/pagedetail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/cart.dart';

class pageview extends StatefulWidget {
  final String user;
  final String number;
  const pageview({super.key, required this.user, required this.number});

  @override
  State<pageview> createState() => _pageviewState();
}

class _pageviewState extends State<pageview>
    with SingleTickerProviderStateMixin {
  double screenHeight = 0;
  double screenWidth = 0;
  String find = "";
  List SearchResult = [];
  void searchfromfirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('productcf')
        .where('namecf', isEqualTo: query)
        .get();
    setState(() {
      SearchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  void searchfromfirebasetea(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('producthealthy')
        .where('namecf', isEqualTo: query)
        .get();
    setState(() {
      SearchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  void searchfromfirebaseht(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('productmilktea')
        .where('namecf', isEqualTo: query)
        .get();
    setState(() {
      SearchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  void searchfromfirebasegas(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('gasdrinks')
        .where('namecf', isEqualTo: query)
        .get();
    setState(() {
      SearchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  late final TabController _tapController =
      TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 235, 214),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            homeAppbar(widget.user, widget.number),
            const SizedBox(
              height: 10,
            ),
            //thanh tim kiem
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 37, 0, 100),
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: "nhập tên sản phẩm",
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          find = query;
                        });
                        searchfromfirebase(query);
                        searchfromfirebaseht(query);
                        searchfromfirebasetea(query);
                        searchfromfirebasegas(query);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 37, 0, 100),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
            //end thanh tim kiem
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: _tapController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.only(right: 10),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: [
                createrTabBar(Icons.local_bar, "cà phê"),
                createrTabBar(Icons.local_bar, "Trà"),
                createrTabBar(Icons.local_bar, "Sức Khỏe"),
                createrTabBar(Icons.local_bar, "Nước ngọt"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tapController,
                children: [
                  find == "" ? coffedrinksview() : timkiem(),
                  find == "" ? milkteasviews() : timkiem(),
                  find == "" ? healthyview() : timkiem(),
                  find == "" ? gasdrinksview() : timkiem(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget homeAppbar(String user, String number) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${user}",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Table: ${number}",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<List<cartmodel>>(
              stream: firebasecard.read(widget.number),
              builder: (context, snapshot) {
                return GestureDetector(
                  child: Center(
                    child: Badge(
                        badgeContent: Text(
                          '${snapshot.data?.length}',
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        child: Icon(Icons.shopping_cart_outlined)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => cartview(
                          nameuser: widget.user,
                          tenban: widget.number,
                        ),
                      ),
                    );
                  },
                );
              }),
          IconButton(
              onPressed: () {
                if (widget.user == "cashier") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pageNhanVien(nameNV: "cashier"),
                      ));
                }
              },
              icon: Icon(Icons.admin_panel_settings)),
        ],
      );

  //tabs
  Widget createrTabBar(IconData icon, String text) => Container(
        height: 35,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 37, 0, 100),
              size: 16,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: const Color.fromARGB(255, 37, 0, 100),
              ),
            )
          ],
        ),
      );

  ///
  Widget coffedrinksview() => Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Coffee-Drinks",
            style: GoogleFonts.aBeeZee(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.brown),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<ProductModeCf>>(
            stream: Firestorehelper.read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("some erros"),
                );
              }
              //load du lieu firebase
              if (snapshot.hasData) {
                final coffeedata = snapshot.data;
                return Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: coffeedata!.length,
                  itemBuilder: (context, index) {
                    final productcf = coffeedata[index];
                    return Container(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              ClipPath(
                                clipper: CustomerClipPath(),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Color.fromARGB(255, 210, 235, 214),
                                  // color: Color.fromARGB(255, 86, 105, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.bottomLeft,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                productcf.namecf,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "loai: ${productcf.typecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "price: ${productcf.pricecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            left: 30,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                print(widget.number);
                                print("${productcf.namecf}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => pageviewdetail(
                                        cfdrink: productcf,
                                        tenban: widget.number),
                                  ),
                                );
                              },
                              child: Image.network(
                                productcf.imagecf,
                                height: 140,
                                width: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      );

  //milkteas
  Widget milkteasviews() => Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "MILK TEA",
            style: GoogleFonts.aBeeZee(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.brown),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<ProductModeCf>>(
            stream: Firestorehelpermilktea.read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("some erros"),
                );
              }
              //load du lieu firebase
              if (snapshot.hasData) {
                final coffeedata = snapshot.data;
                return Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: coffeedata!.length,
                  itemBuilder: (context, index) {
                    final productcf = coffeedata[index];
                    return Container(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              ClipPath(
                                clipper: CustomerClipPath(),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Color.fromARGB(255, 210, 235, 214),
                                  // color: Color.fromARGB(255, 86, 105, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.bottomLeft,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                productcf.namecf,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "loai: ${productcf.typecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "price: ${productcf.pricecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            left: 30,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                print(widget.number);
                                print("${productcf.namecf}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => pageviewdetail(
                                        cfdrink: productcf,
                                        tenban: widget.number),
                                  ),
                                );
                              },
                              child: Image.network(
                                productcf.imagecf,
                                height: 140,
                                width: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      );
  //healthyview
  Widget healthyview() => Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Healthy-drinks",
            style: GoogleFonts.aBeeZee(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.brown),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<ProductModeCf>>(
            stream: Firestorehelperheathy.readheathy(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("some erros"),
                );
              }
              //load du lieu firebase
              if (snapshot.hasData) {
                final coffeedata = snapshot.data;
                return Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: coffeedata!.length,
                  itemBuilder: (context, index) {
                    final productcf = coffeedata[index];
                    return Container(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              ClipPath(
                                clipper: CustomerClipPath(),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Color.fromARGB(255, 210, 235, 214),
                                  // color: Color.fromARGB(255, 86, 105, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.bottomLeft,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                productcf.namecf,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "loai: ${productcf.typecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "price: ${productcf.pricecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            left: 30,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                print(widget.number);
                                print("${productcf.namecf}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => pageviewdetail(
                                        cfdrink: productcf,
                                        tenban: widget.number),
                                  ),
                                );
                              },
                              child: Image.network(
                                productcf.imagecf,
                                height: 140,
                                width: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      );
  //gasdrinksview
  Widget gasdrinksview() => Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Gas-Drinks",
            style: GoogleFonts.aBeeZee(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.brown),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<List<ProductModeCf>>(
            stream: Firestorehelpergasdrinks.readgas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("some erros"),
                );
              }
              //load du lieu firebase
              if (snapshot.hasData) {
                final coffeedata = snapshot.data;
                return Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: coffeedata!.length,
                  itemBuilder: (context, index) {
                    final productcf = coffeedata[index];
                    return Container(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              ClipPath(
                                clipper: CustomerClipPath(),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  color: Color.fromARGB(255, 210, 235, 214),
                                  // color: Color.fromARGB(255, 86, 105, 89),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.bottomLeft,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                productcf.namecf,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "loai: ${productcf.typecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "price: ${productcf.pricecf}",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            left: 30,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                print(widget.number);
                                print("${productcf.namecf}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => pageviewdetail(
                                        cfdrink: productcf,
                                        tenban: widget.number),
                                  ),
                                );
                              },
                              child: Image.network(
                                productcf.imagecf,
                                height: 140,
                                width: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      );
  Widget timkiem() => Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 8,
          ),
          itemCount: SearchResult.length,
          itemBuilder: (context, index) {
            return Container(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      ClipPath(
                        clipper: CustomerClipPath(),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          color: Color.fromARGB(255, 210, 235, 214),
                          // color: Color.fromARGB(255, 86, 105, 89),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        SearchResult[index]['namecf'],
                        style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "loai: ${SearchResult[index]['phanloai']}",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "price: ${SearchResult[index]['giatien']}",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 12,
                                letterSpacing: 0.5,
                                color: Colors.blue,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    left: 30,
                    top: 15,
                    child: GestureDetector(
                      onTap: () {
                        print(widget.number);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => pageviewdetail(
                                cfdrink: SearchResult[index],
                                tenban: widget.number),
                          ),
                        );
                      },
                      child: Image.network(
                        SearchResult[index]['image'],
                        height: 140,
                        width: 100,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
}

class CustomerClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(30, 0); //start pont
    path.quadraticBezierTo(20, 0, 15, 10); //middle point end point
    path.lineTo(0, height - 20); //start point
    path.quadraticBezierTo(2, height, 25, height); //middle point end point
    path.lineTo(width - 25, height); //start point
    path.quadraticBezierTo(
        width - 2, height, width, height - 20); //middle point end point
    path.lineTo(width - 20, 10);
    path.quadraticBezierTo(width - 20, 0, width - 30, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
