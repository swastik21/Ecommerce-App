import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentHandler {
  final String? payIntentId;
  final bool isError;
  final String message;

  PaymentHandler({
    this.payIntentId,
    required this.isError,
    required this.message,
  });
}

class PaymentService {
  PaymentService();

  Future<PaymentHandler> intentPaymentSheet(
      User user, double totalAmount) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://us-central1-my-eccm-project.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': user.email,
            'amount': (totalAmount * 100).toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Ecommerce',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          testEnv: true,
          merchantCountryCode: 'IND',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return PaymentHandler(
          isError: false,
          message: "Success",
          payIntentId: jsonResponse['paymentIntent']);
    } catch (e) {
      if (e is StripeException) {
        return PaymentHandler(
            isError: true,
            message: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        return PaymentHandler(isError: true, message: 'Error: $e');
      }
    }
  }
}
