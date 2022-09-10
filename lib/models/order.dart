import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product.dart';

class Order {
  String confirmationId;
  Timestamp timestamp;
  List<Product> products;

  Order({
    required this.confirmationId,
    required this.timestamp,
    required this.products,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    final timeStamps =
        map['timestamp'] == null ? currentTime : map['timestamp'] as Timestamp;

    return Order(
      confirmationId: map['confirmationId'],
      timestamp: timeStamps,
      products: (map['products'] as List<dynamic>)
          .map((product) => Product.fromMap(product))
          .toList(),
    );
  }
}
