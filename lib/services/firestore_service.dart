import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user_data.dart';

import '../models/order.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
    // await firestore
    //     .collection("products")
    //     .add(product.toMap())
    //     .then((value) => print(value))
    //     .catchError((onError) => print("Error"));
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Product.fromMap(d);
            }).toList());
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }

  Future<void> addUser(UserData user) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  Future<void> saveOrder(String confirmationId, List<Product> products) async {
    await firestore.collection("users").doc(uid).collection("orders").add({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.id!)).toList(),
      'timeStamp': FieldValue.serverTimestamp(),
    });
    await firestore.collection("orders").doc(confirmationId).set({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.id!)).toList(),
      'timeStamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Order>> getOrders() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final orders = doc.data();
              return Order.fromMap(orders);
            }).toList());
  }
}
