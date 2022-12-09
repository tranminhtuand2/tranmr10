import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/product_fb.dart';

class Firestorehelpergasdrinks {
  //create a new productcf
  static Future creategas(ProductModeCf productcf) async {
    final productcoffee = FirebaseFirestore.instance.collection('gasdrinks');
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
  static Stream<List<ProductModeCf>> readgas() {
    final productColectioncf =
        FirebaseFirestore.instance.collection("gasdrinks");
    return productColectioncf.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => ProductModeCf.fromSnapshot(e)).toList());
  }

  //update the product
  static Future updategas(ProductModeCf productcf) async {
    final productgas = FirebaseFirestore.instance.collection('gasdrinks');

    final docRef = productgas.doc(productcf.id);
    final newproductgas = ProductModeCf(
      id: productcf.id,
      namecf: productcf.namecf,
      typecf: productcf.typecf,
      desciptioncf: productcf.desciptioncf,
      imagecf: productcf.imagecf,
      pricecf: productcf.pricecf,
    ).toJson();
    try {
      await docRef.update(newproductgas);
    } catch (e) {
      print("some error $e");
    }
  }

  //delete the product
  static Future deletegas(ProductModeCf deleteproduct) async {
    final productColectioncfupdate =
        FirebaseFirestore.instance.collection("gasdrinks");
    final docRef = productColectioncfupdate.doc(deleteproduct.id).delete();
  }
}
