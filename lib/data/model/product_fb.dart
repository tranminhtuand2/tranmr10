// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModeCf {
  final String? id;
  final String namecf;
  final String typecf;
  final String desciptioncf;
  final String imagecf;
  final String pricecf;
  ProductModeCf({
    this.id,
    required this.namecf,
    required this.typecf,
    required this.desciptioncf,
    required this.imagecf,
    required this.pricecf,
  });
  factory ProductModeCf.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProductModeCf(
      namecf: snapshot['namecf'],
      typecf: snapshot['phanloai'],
      desciptioncf: snapshot['mieuta'],
      imagecf: snapshot['image'],
      pricecf: snapshot['giatien'],
      id: snapshot['id'],
    );
  }
  Map<String, dynamic> toJson() => {
        "namecf": namecf,
        "phanloai": typecf,
        "giatien": pricecf,
        "mieuta": desciptioncf,
        "image": imagecf,
        "id": id,
      };
}
