// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class bill {
  final String subtotal;
  final String khuyenmai;
  final String thanhtien;
  bill({
    required this.subtotal,
    required this.khuyenmai,
    required this.thanhtien,
  });
  factory bill.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return bill(
      subtotal: snapshot['subtotal'],
      khuyenmai: snapshot['khuyenmai'],
      thanhtien: snapshot['thanhtien'],
    );
  }
  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "khuyenmai": khuyenmai,
        "thanhtien": thanhtien,
      };
}
