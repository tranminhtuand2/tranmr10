import 'package:coffemanger/data/model/bill.dart';
import 'package:coffemanger/data/model/cart.dart';
import 'package:coffemanger/data/remote_data_source/firebase_bill.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_cart.dart';
import 'package:coffemanger/userscreen/succespage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cartview extends StatefulWidget {
  final String nameuser;
  final String tenban;
  const cartview({super.key, required this.nameuser, required this.tenban});

  @override
  State<cartview> createState() => _cartviewState();
}

class _cartviewState extends State<cartview> {
  TextEditingController _makm = TextEditingController();
  double khuyenmai = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                "Danh Sách ${widget.tenban}",
                style: GoogleFonts.aBeeZee(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              // leading: IconButton(
              //   onPressed: () {
              //     setState(() {});
              //   },
              //   icon: const Icon(
              //     Icons.arrow_back_ios,
              //     color: Colors.black,
              //   ),
              // ),
            ),
            body: SingleChildScrollView(
              child: StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(widget.tenban),
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
                  if (snapshot.hasData) {
                    final cardtable = snapshot.data;
                    // double demtien = 0;
                    // double tongtien = 0;
                    // double thanhtien = 0;

                    // for (var i = 0; i < cardtable!.length; i++) {
                    //   demtien = double.parse(cardtable[i].giatien);
                    //   tongtien += demtien;
                    // }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: height * 0.7,
                            child: ListView.builder(
                              itemCount: cardtable!.length,
                              itemBuilder: (context, index) {
                                final viewcart = cardtable[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromARGB(255, 201, 196, 183),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child:
                                              Image.network(viewcart.hinhanh),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                viewcart.name,
                                                style: GoogleFonts.aBeeZee(
                                                    color: Color.fromARGB(
                                                        255, 41, 37, 37),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "so luong: ${viewcart.soluong}",
                                                style: GoogleFonts.aBeeZee(
                                                    color: Color.fromARGB(
                                                        255, 41, 37, 37),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "price: ${viewcart.giatien}",
                                                style: GoogleFonts.aBeeZee(
                                                    color: Color.fromARGB(
                                                        255, 216, 77, 77),
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "Type: ${viewcart.type}",
                                                style: GoogleFonts.aBeeZee(
                                                    color: Color.fromARGB(
                                                        255, 216, 77, 77),
                                                    fontSize: 14),
                                              ),
                                              Container(
                                                width: 150,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                    viewcart.ghichu != ""
                                                        ? "Note: ${viewcart.ghichu}"
                                                        : "",
                                                    maxLines: 1,
                                                    style: GoogleFonts.aBeeZee(
                                                        color: Color.fromARGB(
                                                            255, 216, 77, 77),
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("delete"),
                                                    content:
                                                        Text("ban co muon xoa"),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            firebasecard
                                                                .delete(
                                                                    viewcart,
                                                                    widget
                                                                        .tenban)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text("delete"))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              firebasebill.create(
                                  bill(
                                      subtotal: "",
                                      khuyenmai: "",
                                      thanhtien: ""),
                                  widget.tenban);
                              firebasecard.creattinhtrang(widget.tenban);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ordersucces(tenban: widget.tenban),
                                  ));
                              print(widget.tenban);
                            },
                            child: Text("XÁC NHẬN ĐƠN HÀNG"))
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: 50,
                        //     // color: Colors.black,
                        //     // child: Row(
                        //     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     //   children: [
                        //     //     Expanded(
                        //     //       child: TextFormField(
                        //     //         controller: _makm,
                        //     //         decoration: InputDecoration(
                        //     //             fillColor: Colors.grey,
                        //     //             focusColor: Colors.grey,
                        //     //             labelText: "promo code",
                        //     //             border: OutlineInputBorder(
                        //     //                 borderRadius:
                        //     //                     BorderRadius.circular(12))),
                        //     //       ),
                        //     //     ),
                        //     //     Padding(
                        //     //       padding: const EdgeInsets.symmetric(
                        //     //           horizontal: 10),
                        //     //       child: ElevatedButton(
                        //     //           style: ElevatedButton.styleFrom(
                        //     //               shape: RoundedRectangleBorder(
                        //     //                   borderRadius:
                        //     //                       BorderRadius.circular(15)),
                        //     //               backgroundColor:
                        //     //                   Color.fromARGB(255, 76, 24, 207)),
                        //     //           onPressed: () {
                        //     //             setState(() {
                        //     //               if (_makm.text == "KM20") {
                        //     //                 khuyenmai = 20;
                        //     //               } else if (_makm.text == "KM10") {
                        //     //                 khuyenmai = 10;
                        //     //               } else {
                        //     //                 khuyenmai = 0;
                        //     //               }
                        //     //             });
                        //     //           },
                        //     //           child: Text("Aplly")),
                        //     //     )
                        //     //   ],
                        //     // ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Sub Total : ",
                        //             style: GoogleFonts.aBeeZee(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //           Text(
                        //             "${tongtien}\$",
                        //             style: GoogleFonts.aBeeZee(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //         ],
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               "giam gia :  ",
                        //               style: GoogleFonts.aBeeZee(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.w700),
                        //             ),
                        //             Text(
                        //               "${khuyenmai}%",
                        //               style: GoogleFonts.aBeeZee(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.w700),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               "Thanh tien : ",
                        //               style: GoogleFonts.aBeeZee(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.w700),
                        //             ),
                        //             Text(
                        //               "${thanhtien = tongtien - (tongtien * khuyenmai / 100)}\$",
                        //               style: GoogleFonts.aBeeZee(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.w700),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         firebasecard.creattinhtrang(widget.tenban);
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) => ordersucces(),
                        //             ));
                        //       },
                        //       child: Text("thanh toan")),
                        // )
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )));
  }
}
