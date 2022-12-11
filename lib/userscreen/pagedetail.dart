import 'package:badges/badges.dart';
import 'package:coffemanger/data/model/cart.dart';
import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/model/thongke.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_cart.dart';
import 'package:coffemanger/data/remote_data_source/firebase_thongke.dart';
import 'package:coffemanger/userscreen/cartview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class pageviewdetail extends StatefulWidget {
  final ProductModeCf cfdrink;
  final String tenban;
  const pageviewdetail(
      {super.key, required this.cfdrink, required this.tenban});

  @override
  State<pageviewdetail> createState() => _pageviewdetailState();
}

class _pageviewdetailState extends State<pageviewdetail> {
  int count = 1;

  double tien = 0;

  TextEditingController _ghichu = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: coffeeDrinkBottonSheet(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(widget.tenban),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => cartview(
                              nameuser: "",
                              tenban: widget.tenban,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Badge(
                            badgeContent: Text(
                              '${snapshot.data?.length}',
                              style: GoogleFonts.aBeeZee(color: Colors.white),
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  );
                })
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          centerTitle: true,
          title: Text(
            "detail product",
            style: GoogleFonts.aBeeZee(color: Colors.amber),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 320,
                width: double.infinity,
                // color: Colors.amber,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: CustumPath(),
                        child: Container(
                          height: 250,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(15, 199, 144, 129),
                                  Color.fromARGB(155, 233, 165, 121),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Image.network(
                        widget.cfdrink.imagecf,
                        height: 310,
                        width: 280,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cfdrink.namecf,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Loai: ${widget.cfdrink.typecf}",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    RatingBar.builder(
                      onRatingUpdate: (value) {},
                      itemCount: 5,
                      itemSize: 25,
                      initialRating: 5,
                      unratedColor: Colors.grey.shade400,
                      allowHalfRating: true,
                      itemBuilder: (context, index) {
                        return const Icon(
                          Icons.star,
                          // color: Color.fromARGB(255, 72, 98, 23),
                          color: Colors.brown,
                        );
                      },
                    )
                  ],
                ),
              ),
              const Divider(
                height: 40,
                color: Colors.black,
              ),
              Text(
                "product Description",
                style: GoogleFonts.aBeeZee(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.cfdrink.desciptioncf,
                  style: GoogleFonts.aBeeZee(fontSize: 14, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget coffeeDrinkBottonSheet() => Container(
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 103, 192, 95),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _ghichu,
                decoration: InputDecoration(
                  labelText: "ghi chu",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tien == 0 ? '\$ ${widget.cfdrink.pricecf}' : '\$ ${tien}',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                      right: Radius.circular(20),
                    ),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (count <= 1) {
                              return;
                            } else {
                              count--;
                            }

                            tien = count * double.parse(widget.cfdrink.pricecf);
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "$count",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                            tien = count * double.parse(widget.cfdrink.pricecf);
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      print(count);
                      print(tien);
                      print(widget.tenban);

                      // them du lieu vao database
                      firebasecard.createcart(
                          cartmodel(
                              name: widget.cfdrink.namecf,
                              soluong: "$count",
                              type: widget.cfdrink.typecf,
                              hinhanh: widget.cfdrink.imagecf,
                              giatien:
                                  tien == 0 ? widget.cfdrink.pricecf : "$tien",
                              ghichu: _ghichu.text),
                          widget.tenban);
                      firebasethongke.createTK(thongke(
                          name: widget.cfdrink.typecf, soluong: "$count"));
                      Navigator.pop(context);

                      //  Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (context) => cartview(),
                      //               ),
                      //             );
                    },
                    child: Text(
                      "Cart",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 79, 34, 186)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class CustumPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;
    path.moveTo(50, 0); //start pont
    path.quadraticBezierTo(20, 0, 15, 40); //middle point end point
    path.lineTo(0, height - 40); //start point
    path.quadraticBezierTo(2, height, 50, height); //middle point end point
    path.lineTo(width - 50, height); //start point
    path.quadraticBezierTo(
        width, height, width, height - 40); //middle point end point
    path.lineTo(width - 20, 35);
    path.quadraticBezierTo(width - 20, 0, width - 50, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
