import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:barcode_scanner/classical_components/barcode_camera.dart';
import 'package:coffemanger/constaints/buttonwidget.dart';
import 'package:coffemanger/nhanvien/pagenhanvien.dart';
import 'package:coffemanger/userscreen/pageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'admin/admincategroies.dart';

class trangtru extends StatefulWidget {
  const trangtru({super.key});

  @override
  State<trangtru> createState() => _trangtruState();
}

class _trangtruState extends State<trangtru> {
  final _formkey = GlobalKey<FormState>();
  String qrcode = '';
  TextEditingController _nameuser = TextEditingController();
  TextEditingController _numbertable = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sizewidth = MediaQuery.of(context).size.width;
    var sizeheigth = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "COFFEE WINDS",
          style: GoogleFonts.anton(),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset("assets/images/logocf.png"),
                  ),
                  Text(
                    "Xin chào quý khách",
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameuser,
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        focusColor: Colors.grey,
                        labelText: "vui lòng nhập tên",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(qrcode == '' ? "please scan QR" : qrcode,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      ElevatedButton(
                          onPressed: () {
                            scanQRcode();
                          },
                          child: Image.asset(
                            "assets/images/qrcode.png",
                            height: 20,
                            width: 20,
                          )),
                    ],
                  ),

                  // TextFormField(
                  //   controller: _numbertable,
                  //   decoration: InputDecoration(
                  //       fillColor: Colors.grey,
                  //       focusColor: Colors.grey,
                  //       labelText: "vui long nhap so ban hoac quet ma qr",
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(12))),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'number table';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        if (_nameuser.text == "admin") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminCategroies(admin: _nameuser.text),
                            ),
                          );
                        } else if (_nameuser.text == "pk02579") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  pageNhanVien(nameNV: _nameuser.text),
                            ),
                          );
                        } else if (qrcode == "b1" ||
                            qrcode == "b2" ||
                            qrcode == "b3" ||
                            qrcode == "b4" ||
                            qrcode == "b5" ||
                            qrcode == "b6") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pageview(
                                  user: _nameuser.text,
                                  number: qrcode,
                                ),
                              ));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("error message"),
                              content: Text("please scanQRcode"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("confirm"))
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "xac nhan",
                      style: GoogleFonts.roboto(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void scanQRcode() async {
    try {
      String qrResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.DEFAULT);

      if (!mounted) return;
      setState(() {
        qrcode = qrResult;
      });
      print("object");
      print(qrResult);
    } on PlatformException {
      qrcode = "failt scan barcode";
    }
  }

  // Future<void> scanQrCode() async {
  //   try {
  //     final qrcode = await FlutterBarcodeScanner.scanBarcode(
  //         '#5a693', 'cancel', true, ScanMode.QR);
  //     if (!mounted) return;
  //   } on PlatformException {
  //     qrcode = 'failed to get';
  //   }
  // }
}
