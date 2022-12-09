// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class tinhtrang {
  final String tinhtrangDH;
  tinhtrang({
    required this.tinhtrangDH,
  });
  factory tinhtrang.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return tinhtrang(
      tinhtrangDH: snapshot['tinhtrang'],
    );
  }
  Map<String, dynamic> toJson() => {
        "tinhtrang": tinhtrangDH,
      };
}
