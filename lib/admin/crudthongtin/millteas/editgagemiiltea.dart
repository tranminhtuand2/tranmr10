import 'dart:io';

import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_gasdrink.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_heathy.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper_milktea.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class editpageteas extends StatefulWidget {
  final ProductModeCf productcf;
  const editpageteas({
    super.key,
    required this.productcf,
  });

  @override
  State<editpageteas> createState() => _editpageteasState();
}

class _editpageteasState extends State<editpageteas> {
  TextEditingController? _namecf;

  TextEditingController? _loaicf;

  TextEditingController? _mieuta;

  TextEditingController? _giatien;
  late File imagefile;
  String imgUrl = '';

  @override
  void initState() {
    _namecf = TextEditingController(text: widget.productcf.namecf);
    _loaicf = TextEditingController(text: widget.productcf.typecf);

    _giatien = TextEditingController(text: widget.productcf.pricecf);
    _mieuta = TextEditingController(text: widget.productcf.desciptioncf);
    super.initState();
  }

  @override
  void dispose() {
    _namecf!.dispose();
    _loaicf!.dispose();
    _mieuta!.dispose();
    _giatien!.dispose();
    super.dispose();
  }

  void pickuploadimage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 95,
    );
    setState(() {
      try {
        imagefile = File(image!.path);
      } catch (e) {
        print("object $e");
      }
    });
    Reference ref = FirebaseStorage.instance.ref().child("$imagefile");
    try {
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) {
        print(value);
        setState(() {
          imgUrl = value;
        });
      });
    } catch (e) {
      print("some error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("page edit"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: _namecf,
              decoration: InputDecoration(
                labelText: "name product",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _giatien,
              decoration: InputDecoration(
                labelText: "price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _loaicf,
              decoration: InputDecoration(
                labelText: "type product",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _mieuta,
              decoration: InputDecoration(
                labelText: "description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  width: 150,
                  height: 150,
                  child: imgUrl == ""
                      ? Image.network(
                          widget.productcf.imagecf,
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          imgUrl,
                          fit: BoxFit.contain,
                        ),
                )),
                GestureDetector(
                  onTap: () {
                    pickuploadimage();
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Icon(Icons.folder),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print("update datacoffee");
                  Firestorehelpermilktea.update(
                    ProductModeCf(
                      id: widget.productcf.id,
                      namecf: _namecf!.text,
                      typecf: _loaicf!.text,
                      desciptioncf: _mieuta!.text,
                      imagecf: imgUrl == "" ? widget.productcf.imagecf : imgUrl,
                      pricecf: _giatien!.text,
                    ),
                  ).then((value) {
                    Navigator.pop(context);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('cap nhat thanh cong'),
                    duration: const Duration(seconds: 1),
                    // action: SnackBarAction(
                    //   label: 'ACTION',
                    //   onPressed: () {},
                    // ),
                  ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Update",
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
