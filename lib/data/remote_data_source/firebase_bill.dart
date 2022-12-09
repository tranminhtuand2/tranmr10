import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/bill.dart';

class firebasebill {
  //create bill
  static Future create(bill hoadon, String tenban) async {
    final billColection = FirebaseFirestore.instance.collection("bill$tenban");
    final docRef = billColection.doc("detailbill$tenban");
    final newhoadon = bill(
      subtotal: hoadon.subtotal,
      khuyenmai: hoadon.khuyenmai,
      thanhtien: hoadon.thanhtien,
    ).toJson();
    try {
      await docRef.set(newhoadon);
    } catch (e) {
      print("some error $e");
    }
  }

  //create total
  static Future createtotal(bill hoadon) async {
    final billColection = FirebaseFirestore.instance.collection("tongtien");
    final docRef = billColection.doc();
    final newhoadon = bill(
      subtotal: hoadon.subtotal,
      khuyenmai: hoadon.khuyenmai,
      thanhtien: hoadon.thanhtien,
    ).toJson();
    try {
      await docRef.set(newhoadon);
    } catch (e) {
      print("some error $e");
    }
  }

  //read total
  static Stream<List<bill>> readtotal() {
    final billColection = FirebaseFirestore.instance.collection("tongtien");
    return billColection.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => bill.fromSnapshot(e)).toList());
  }

  //read
  static Stream<List<bill>> read(String tenban) {
    final billColection = FirebaseFirestore.instance.collection("bill$tenban");
    return billColection.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => bill.fromSnapshot(e)).toList());
  }

  //delete
  static Future removebill(String tenban) async {
    var cartremove = FirebaseFirestore.instance.collection("bill$tenban");
    var Snapshot = await cartremove.get();
    // Snapshot.docs[0].reference.delete();
    for (var doc in Snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
