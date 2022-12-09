// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/admin/crudthongtin/coffee/screencoffe.dart';
import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/remote_data_source/firebase_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class crudcoffee extends StatefulWidget {
  const crudcoffee({super.key, required this.title});
  final String title;

  @override
  State<crudcoffee> createState() => _crudcoffeeState();
}

class _crudcoffeeState extends State<crudcoffee> {
  TextEditingController _namecf = TextEditingController();

  TextEditingController _loaicf = TextEditingController();

  TextEditingController _hinhanh = TextEditingController();

  TextEditingController _mieuta = TextEditingController();

  TextEditingController _giatien = TextEditingController();
  late File imagefile;
  String imgUrl = '';
  @override
  void dispose() {
    _namecf.dispose();
    _loaicf.dispose();
    _hinhanh.dispose();
    _mieuta.dispose();
    _giatien.dispose();
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
        appBar: AppBar(title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
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
                          ? Text("HINH ANH")
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
                      print("create datacoffee");
                      Firestorehelper.create(ProductModeCf(
                          namecf: _namecf.text,
                          typecf: _loaicf.text,
                          desciptioncf: _mieuta.text,
                          imagecf: imgUrl,
                          pricecf: _giatien.text));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('them thanh cong'),
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
                              "create",
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => udcoffee(),
                          ));
                    },
                    icon: Icon(Icons.arrow_circle_right))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //database

}
