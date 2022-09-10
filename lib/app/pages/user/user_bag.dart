// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBag extends ConsumerWidget {
  const UserBag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final bagViewModel = ref.watch(bagProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Flexible(
                    child: Text(
                      "My Bag",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: bagViewModel.isbagEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        itemCount: bagViewModel.totalProducts,
                        itemBuilder: ((context, index) {
                          final product = bagViewModel.productsBag[index];
                          return ListTile(
                            title: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text("Rs. ${product.price.toString()}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                bagViewModel.removeProduct(product);
                              },
                            ),
                          );
                        }),
                      ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: Rs. ${bagViewModel.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final payment = ref.read(paymentProvider);
                          final user = ref.read(authStateChangesProvider);
                          final userBag = ref.read(bagProvider);
                          final result = await payment.intentPaymentSheet(
                              user.value!, userBag.totalPrice);
                          if (!result.isError) {
                            ref.read(databaseProvider)!.saveOrder(
                                result.payIntentId!, userBag.productsBag);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Payment completed!'),
                              ),
                            );
                            userBag.clearbag();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(result.message),
                            ));
                          }
                        },
                        child: const Text("Checkout"),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
