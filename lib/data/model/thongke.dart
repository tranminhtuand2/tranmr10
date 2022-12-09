import 'package:cloud_firestore/cloud_firestore.dart';

class thongke {
  final String name;
  final String soluong;

  thongke({
    required this.name,
    required this.soluong,
  });
  factory thongke.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return thongke(
      name: snapshot['name'],
      soluong: snapshot['soluong'],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "soluong": soluong,
      };
}
