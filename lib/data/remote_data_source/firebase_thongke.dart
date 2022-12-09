import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/thongke.dart';

class firebasethongke {
  //create bill
  static Future createTK(thongke hoadon) async {
    final billColection = FirebaseFirestore.instance.collection("thongke");
    final docRef = billColection.doc();
    final newhoadon = thongke(
      name: hoadon.name,
      soluong: hoadon.soluong,
    ).toJson();
    try {
      await docRef.set(newhoadon);
    } catch (e) {
      print("some error $e");
    }
  }

  //read
  static Stream<List<thongke>> readTK() {
    final billColection = FirebaseFirestore.instance.collection("thongke");
    return billColection.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => thongke.fromSnapshot(e)).toList());
  }

  //delete
  static Future removethongke(String tenban) async {
    var cartremove = FirebaseFirestore.instance.collection("bill$tenban");
    var Snapshot = await cartremove.get();
    // Snapshot.docs[0].reference.delete();
    for (var doc in Snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
