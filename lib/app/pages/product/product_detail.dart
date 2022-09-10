import 'dart:ui';

import 'package:ecommerce/app/pages/user/user_bag.dart';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetail extends ConsumerWidget {
  const ProductDetail({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            UserTopBar(
              leadingIconButton: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Hero(
              tag: product.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "My Store",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              product.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Description",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Text(
              product.description,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Rs. ${product.price.toString()}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                ref.read(bagProvider).addProduct(product);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserBag()));
              },
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    "Add to Bag",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
