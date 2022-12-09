import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/product_fb.dart';

class Firestorehelpermilktea {
  //create a new productcf
  static Future createmilk(ProductModeCf productcf) async {
    final productcoffee =
        FirebaseFirestore.instance.collection('productmilktea');
    final uid = productcoffee.doc().id;
    final docRef = productcoffee.doc(uid);
    final newproductcf = ProductModeCf(
      id: uid,
      namecf: productcf.namecf,
      typecf: productcf.typecf,
      desciptioncf: productcf.desciptioncf,
      imagecf: productcf.imagecf,
      pricecf: productcf.pricecf,
    ).toJson();
    try {
      await docRef.set(newproductcf);
    } catch (e) {
      print("some error $e");
    }
  }

  //read the product
  static Stream<List<ProductModeCf>> read() {
    final productColectioncf =
        FirebaseFirestore.instance.collection("productmilktea");
    return productColectioncf.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => ProductModeCf.fromSnapshot(e)).toList());
  }

  //update the product
  static Future update(ProductModeCf productcf) async {
    final productcoffee =
        FirebaseFirestore.instance.collection('productmilktea');

    final docRef = productcoffee.doc(productcf.id);
    final newproductcf = ProductModeCf(
      id: productcf.id,
      namecf: productcf.namecf,
      typecf: productcf.typecf,
      desciptioncf: productcf.desciptioncf,
      imagecf: productcf.imagecf,
      pricecf: productcf.pricecf,
    ).toJson();
    try {
      await docRef.update(newproductcf);
    } catch (e) {
      print("some error $e");
    }
  }

  //delete the product
  static Future delete(ProductModeCf deleteproduct) async {
    final productColectioncfupdate =
        FirebaseFirestore.instance.collection("productmilktea");
    final docRef = productColectioncfupdate.doc(deleteproduct.id).delete();
  }
}
