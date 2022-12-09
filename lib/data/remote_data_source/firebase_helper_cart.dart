import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/cart.dart';
import 'package:coffemanger/data/model/product_fb.dart';
import 'package:coffemanger/data/model/tinhtrang.dart';

class firebasecard {
  //create cart
  static Future createcart(cartmodel cart, String tenban) async {
    final cartcolection = FirebaseFirestore.instance.collection("${tenban}");
    final uid = cartcolection.doc().id;
    final docRef = cartcolection.doc(uid);
    final carts = cartmodel(
            id: uid,
            name: cart.name,
            soluong: cart.soluong,
            type: cart.type,
            hinhanh: cart.hinhanh,
            giatien: cart.giatien,
            ghichu: cart.ghichu)
        .toJson();
    try {
      await docRef.set(carts);
    } catch (e) {
      print("some error $e");
    }
  }

  //read
  static Stream<List<cartmodel>> read(String tenban) {
    final productColectioncf = FirebaseFirestore.instance.collection("$tenban");
    return productColectioncf.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => cartmodel.fromSnapshot(e)).toList());
  }

  //remove
  static Future delete(cartmodel deleteproduct, String tenban) async {
    final cartdelete = FirebaseFirestore.instance.collection("${tenban}");
    final docRef = cartdelete.doc(deleteproduct.id).delete();
  }

  //remove table
  static Future removetable(String tenban) async {
    var cartremove = FirebaseFirestore.instance.collection("${tenban}");
    var Snapshot = await cartremove.get();
    for (var doc in Snapshot.docs) {
      await doc.reference.delete();
    }
  }

  //
  //tinhtrangdonhang
  // static Future creattinhtrang(tinhtrang TinhTrangdh, String table) async {
  //   final kiemtra = FirebaseFirestore.instance.collection("tinhtrang${table}");
  //   final docRef = kiemtra.doc("id");
  //   final xacnhan = tinhtrang(
  //     tinhtrangDH: TinhTrangdh.tinhtrangDH,
  //   );
  // }
  //them
  static Future creattinhtrang(String tenban) async {
    final kiemtra = FirebaseFirestore.instance.collection("tinhtrang${tenban}");
    final docRef = kiemtra.doc("id");
    await docRef.set({"tinhtrang": "xacnhan"});
  }

  //read
  static Stream<List<tinhtrang>> readtinhtrang(String tenban) {
    final tinhtrangdonhon =
        FirebaseFirestore.instance.collection("tinhtrang$tenban");
    return tinhtrangdonhon.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => tinhtrang.fromSnapshot(e)).toList());
  }

  //xoa
  static Future deletetinhtrang(String table) async {
    final donhangdelete =
        FirebaseFirestore.instance.collection("tinhtrang${table}");
    final docRef = donhangdelete.doc("id").delete();
  }
}
