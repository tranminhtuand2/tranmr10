// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class cartmodel {
  final String? id;
  final String name;
  final String soluong;
  final String type;
  final String giatien;
  final String hinhanh;
  final String ghichu;
  cartmodel({
    this.id,
    required this.name,
    required this.soluong,
    required this.type,
    required this.hinhanh,
    required this.giatien,
    required this.ghichu,
  });
  factory cartmodel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return cartmodel(
      name: snapshot['name'],
      soluong: snapshot['soluong'],
      type: snapshot['phanloai'],
      hinhanh: snapshot['hinhanh'],
      giatien: snapshot['giatien'],
      ghichu: snapshot['ghichu'],
      id: snapshot['id'],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "soluong": soluong,
        "phanloai": type,
        "hinhanh": hinhanh,
        "giatien": giatien,
        "ghichu": ghichu,
        "id": id,
      };
}
