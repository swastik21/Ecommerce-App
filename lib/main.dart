import 'package:ecommerce/app/auth_widget.dart';
import 'package:ecommerce/app/pages/auth/sign_in_page.dart';
import 'package:ecommerce/app/pages/user/user_home.dart';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'app/pages/admin/admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeRemoteConfig();
  Stripe.publishableKey =
      "pk_test_51LcCJPSJRBzNxiUYID1mEiKvEeriKKYQheK70qbh2fU3IU4OJtQJe0YF3mCVCz6nBLRgwoGmpbbAmlawApLhTdPA009FO2PcES";
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.orange,
          seedColor: Colors.orange,
        ),
      ),
      home: AuthWidget(
        signedInBuilder: (context) => const UserHome(),
        nonSignedInBuilder: (_) => const SignInPage(),
        adminSignedBuilder: (context) => const AdminHome(),
      ),
    );
  }
}

_initializeRemoteConfig() async {
  final Map<String, dynamic> defaults = <String, dynamic>{
    'shoes': "shoes",
  };

  final firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  await firebaseRemoteConfig.setDefaults(defaults);

  await firebaseRemoteConfig.setConfigSettings(
    RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero),
  );

  await firebaseRemoteConfig.fetchAndActivate();
}
