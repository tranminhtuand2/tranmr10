import 'dart:math';

import 'package:coffemanger/data/model/bill.dart';
import 'package:coffemanger/data/model/cart.dart';
import 'package:coffemanger/data/remote_data_source/firebase_bill.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_cart.dart';
import 'package:coffemanger/trangtru.dart';
import 'package:coffemanger/userscreen/pageview.dart';
import 'package:coffemanger/userscreen/waitorder.dart';
// import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ordersucces extends StatefulWidget {
  final String tenban;
  const ordersucces({super.key, required this.tenban});

  @override
  State<ordersucces> createState() => _ordersuccesState();
}

class _ordersuccesState extends State<ordersucces> {
  String tien = "";
  String xacnhan = "";
  @override
  Widget build(BuildContext context) {
    double rong = MediaQuery.of(context).size.width;
    double dai = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Order Succes"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: StreamBuilder<List<cartmodel>>(
                stream: firebasecard.read(widget.tenban),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          "vui long cho 1 chut..",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("some erros"),
                    );
                  }
                  if (snapshot.hasData) {
                    final viewbill = snapshot.data;
                    return ListView.builder(
                      itemCount: viewbill!.length,
                      itemBuilder: (context, index) {
                        final viewbills = viewbill[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 20,
                                child: Text(
                                  "${index + 1}.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                child: Text(
                                  viewbills.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              )),
                              Container(
                                width: 50,
                                // color: Colors.blue,
                                child: Text(
                                  "SL:${viewbills.soluong}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 100,
                                // color: Colors.green,
                                child: Text(
                                  "\$:${viewbills.giatien}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        Text(
                          "vui long cho 1 chut..",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              child: StreamBuilder<List<bill>>(
                stream: firebasebill.read(widget.tenban),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        Text(
                          "vui long cho 1 chut..",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        Text(
                          "vui long cho 1 chut..",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ));
                  }
                  if (snapshot.hasData) {
                    xacnhan = "";
                    final bill = snapshot.data![0];
                    tien = bill.thanhtien;
                    if (bill.thanhtien == "") {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              strokeWidth: 6,
                            ),
                            Text(
                              "cooking... please wait...",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      );
                    } else {
                      xacnhan = "done";
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "sub Total:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${bill.subtotal}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "giam gia %:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${bill.khuyenmai}%",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "total money:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${bill.thanhtien}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    // return Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "sub Total:",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "${bill.subtotal}",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "giam gia %:",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "${bill.khuyenmai}%",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "total money:",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //           Text(
                    //             "${bill.thanhtien}",
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.w600),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }

                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 6,
                        ),
                        Text(
                          "vui long cho 1 chut..",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  xacnhan == ""
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("please wait bill")))
                      :
                      // firebasecard.deletetinhtrang(widget.tenban);
                      // firebasecard.removetable(widget.tenban);
                      // firebasebill.removebill(widget.tenban);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => waitorder(tien: tien)),
                        );
                  print(tien);
                },
                child: Text("xac nhan")),
          )
        ],
      ),
    ));
  }
}
