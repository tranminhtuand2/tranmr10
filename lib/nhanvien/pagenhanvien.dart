import 'package:badges/badges.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_cart.dart';
import 'package:coffemanger/nhanvien/pageoder.dart';
import 'package:coffemanger/nhanvien/thongke.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/cart.dart';

class pageNhanVien extends StatefulWidget {
  final String nameNV;
  const pageNhanVien({super.key, required this.nameNV});

  @override
  State<pageNhanVien> createState() => _pageNhanVienState();
}

class _pageNhanVienState extends State<pageNhanVien> {
  String b1 = "b1";
  String b2 = "b2";
  String b3 = "b3";
  String b4 = "b4";
  String b5 = "b5";
  String b6 = "b6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.nameNV),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => tongketDT(),
                ));
          },
          backgroundColor: Colors.blueGrey,
          child: Text("Admin"),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 2,
          children: [
            //ban 1
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b1),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b1),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b1,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),

            //ban2
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b2),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b2),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b2,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),

            //ban3
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b3),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b3),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b3,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),

            //ban 4
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b4),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b4),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b4,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
            //ban 5
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b5),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b5),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b5,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
            //ban 6
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(b6),
                builder: (context, snapshot) {
                  return Badge(
                    badgeContent: Text(
                      snapshot.hasData ? ("${snapshot.data!.length}") : "0",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => cartviewNV(tenban: b6),
                            ));
                      },
                      child: Stack(children: [
                        Positioned(
                            left: 60,
                            top: 0,
                            child: Text(
                              b6,
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.teal[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset("assets/images/ban.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
          ],
        ));
  }
}
