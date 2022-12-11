import 'package:coffemanger/trangtru.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class waitorder extends StatelessWidget {
  final String tien;
  const waitorder({super.key, required this.tien});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                child: Image.asset("assets/images/donhang.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Nhân viên đang chuẩn bị thức uống",
                style: GoogleFonts.aBeeZee(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "vui lòng chuẩn bị ${tien}k \n xin cảm ơn",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => trangtru(),
                        ));
                  },
                  child: Text("back to home"))
            ],
          ),
        ),
      ),
    ));
  }
}
