import 'package:ecommerce/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Product description matches the defined text', () {
    const description = "This is a test description";
    final product = Product(
        name: "Product",
        description: description,
        imageUrl: "imageUrl",
        price: 12.29);
    expect(product.description, description);
  });
  test('Product name matches the defined text', () {
    const name = "Product";
    final product = Product(
        name: name,
        description: "description",
        imageUrl: "imageUrl",
        price: 12.29);
    expect(product.name, name);
  });

  group("Price", () {
    const price = 12.29;
    test("Product price matches the defined price", () {
      final product = Product(
        name: "name",
        description: "description",
        imageUrl: "imageUrl",
        price: price,
      );
      expect(product.price, price);
    });
    test("Getting correct tax from the product", () {
      const tax = price * 1.2;
      final product = Product(
        name: "name",
        description: "description",
        imageUrl: "imageUrl",
        price: price,
      );
      expect(product.priceWithTax, tax);
    });
  });
}
