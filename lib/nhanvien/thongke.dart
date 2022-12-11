import 'package:coffemanger/data/model/bill.dart';
import 'package:coffemanger/data/model/chart_thongke.dart';
import 'package:coffemanger/data/model/thongke.dart';
import 'package:coffemanger/data/remote_data_source/firebase_bill.dart';
import 'package:coffemanger/data/remote_data_source/firebase_thongke.dart';
import 'package:coffemanger/nhanvien/chartproduct.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';

class tongketDT extends StatefulWidget {
  const tongketDT({super.key});

  @override
  State<tongketDT> createState() => _tongketDTState();
}

class _tongketDTState extends State<tongketDT> {
  double tongtien = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("doanh thu"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              child: StreamBuilder<List<bill>>(
                  stream: firebasebill.readtotal(),
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
                            style: GoogleFonts.aBeeZee(fontSize: 30),
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
                            style: GoogleFonts.aBeeZee(fontSize: 30),
                          )
                        ],
                      ));
                    }
                    if (snapshot.hasData) {
                      final tongket = snapshot.data;
                      double tinhtien = 0;

                      for (var i = 0; i < tongket!.length; i++) {
                        tinhtien = double.parse(tongket[i].thanhtien);
                        tongtien += tinhtien;
                        print(tongtien);
                        print(i);
                      }
                      int doanhthu = tongtien.ceil();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "tong tien:",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${tongtien}k",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ],
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
                          style: GoogleFonts.aBeeZee(fontSize: 30),
                        )
                      ],
                    ));
                  }),
            ),
            bangthongke()
          ],
        ),
      ),
    ));
  }
}

class bangthongke extends StatelessWidget {
  const bangthongke({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<thongke>>(
        stream: firebasethongke.readTK(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Text(
                  "vui long cho 1 chut..",
                  style: GoogleFonts.aBeeZee(fontSize: 30),
                )
              ],
            ));
          }
          if (snapshot.hasError) {
            return Center(
                child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Text(
                  "vui long cho 1 chut..",
                  style: GoogleFonts.aBeeZee(fontSize: 30),
                )
              ],
            ));
          }
          if (snapshot.hasData) {
            final thongke = snapshot.data;
            double coffee = 0;
            double teas = 0;
            double juices = 0;
            double smothie = 0;
            double gas = 0;

            for (var i = 0; i < thongke!.length; i++) {
              var vitritk = thongke[i];
              if (vitritk.name == "coffee") {
                double cf = double.parse(vitritk.soluong);
                coffee += cf;
              }
              if (vitritk.name == "tea") {
                double tra = double.parse(vitritk.soluong);
                teas += tra;
              }
              if (vitritk.name == "juice") {
                double juice = double.parse(vitritk.soluong);
                juices += juice;
              }
              if (vitritk.name == "smoothie") {
                double smothies = double.parse(vitritk.soluong);
                smothie += smothies;
              }
              if (vitritk.name == "gas") {
                double drinkgas = double.parse(vitritk.soluong);
                gas += drinkgas;
              }
            }
            final List<thongkeSp> data = [
              thongkeSp(
                name: "coffee",
                soluong: coffee,
                barcolor: charts.ColorUtil.fromDartColor(Colors.brown),
              ),
              thongkeSp(
                name: "juice",
                soluong: juices,
                barcolor: charts.ColorUtil.fromDartColor(Colors.yellow),
              ),
              thongkeSp(
                name: "smothies",
                soluong: smothie,
                barcolor: charts.ColorUtil.fromDartColor(Colors.pink),
              ),
              thongkeSp(
                name: "tea",
                soluong: teas,
                barcolor: charts.ColorUtil.fromDartColor(Colors.green),
              ),
              thongkeSp(
                name: "gas",
                soluong: gas,
                barcolor: charts.ColorUtil.fromDartColor(Colors.red),
              )
            ];
            return Center(
              child: Column(
                children: [
                  Text("bang thong ke san pham da ban"),
                  Container(
                    height: 400,
                    padding: EdgeInsets.all(10),
                    child: chartproduct(data: data),
                  )
                ],
              ),
            );
          }

          return Center(
              child: Column(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              Text(
                "vui long cho 1 chut..",
                style: GoogleFonts.aBeeZee(fontSize: 30),
              )
            ],
          ));
        });
  }
}
