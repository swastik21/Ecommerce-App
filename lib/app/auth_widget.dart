import 'package:ecommerce/app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget(
      {Key? key,
      required this.signedInBuilder,
      required this.nonSignedInBuilder,
      required this.adminSignedBuilder})
      : super(key: key);

  final WidgetBuilder signedInBuilder;
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder adminSignedBuilder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    const adminEmail = "admin@admin.com";
    return authStateChanges.when(
      data: (user) => user != null
          ? user.email == adminEmail
              ? adminSignedBuilder(context)
              : signedInBuilder(context)
          : nonSignedInBuilder(context),
      error: (_, __) => const Scaffold(
        body: Center(
          child: Text("Something went worng!"),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
