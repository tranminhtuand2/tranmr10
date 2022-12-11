import 'package:coffemanger/admin/crudthongtin/coffee/editpagecf.dart';
import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class udcoffee extends StatefulWidget {
  const udcoffee({super.key});

  @override
  State<udcoffee> createState() => _udcoffeeState();
}

class _udcoffeeState extends State<udcoffee> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("admin view coffee"),
      ),
      body: StreamBuilder<List<ProductModeCf>>(
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
            if (snapshot.hasData) {
              final coffeedata = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: coffeedata!.length,
                itemBuilder: (context, index) {
                  final productcf = coffeedata[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            // color: Colors.amber,
                            child: Image.network(productcf.imagecf),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name:${productcf.namecf}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Price: ${productcf.pricecf}.000",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Type:${productcf.typecf}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "describe:${productcf.desciptioncf}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => editpagecf(
                                              productcf: ProductModeCf(
                                                id: productcf.id,
                                                namecf: productcf.namecf,
                                                typecf: productcf.typecf,
                                                desciptioncf:
                                                    productcf.desciptioncf,
                                                imagecf: productcf.imagecf,
                                                pricecf: productcf.pricecf,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                ),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("delete"),
                                              content: Text("ban co muon xoa"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Firestorehelper.delete(
                                                              productcf)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text("delete"))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    ));
  }

  Widget showproduct() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    // child: Image.network(""),
                  ),
                  Column(
                    children: [
                      Text(
                        "Name:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Price:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Type:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Type:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "describe:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ));
}
