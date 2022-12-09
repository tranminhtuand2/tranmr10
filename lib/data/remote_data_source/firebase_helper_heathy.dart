import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemanger/data/model/product_fb.dart';

class Firestorehelperheathy {
  //create a new productcf
  static Future createhealthy(ProductModeCf productcf) async {
    final productcoffee =
        FirebaseFirestore.instance.collection('producthealthy');
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
  static Stream<List<ProductModeCf>> readheathy() {
    final productColectioncf =
        FirebaseFirestore.instance.collection("producthealthy");
    return productColectioncf.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => ProductModeCf.fromSnapshot(e)).toList());
  }

  //update the product
  static Future updateheathy(ProductModeCf productcf) async {
    final productcoffee =
        FirebaseFirestore.instance.collection('producthealthy');

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
  static Future deletehealthy(ProductModeCf deleteproduct) async {
    final productColectioncfupdate =
        FirebaseFirestore.instance.collection("producthealthy");
    final docRef = productColectioncfupdate.doc(deleteproduct.id).delete();
  }
}
