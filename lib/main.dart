import 'package:ecommerce/app/auth_widget.dart';
import 'package:ecommerce/app/pages/auth/sign_in_page.dart';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/pages/admin/admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
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
        signedInBuilder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("signed in"),
                ElevatedButton(
                    onPressed: () => ref.read(firebaseAuthprovider).signOut(),
                    child: const Text("Sign out"))
              ],
            ),
          ),
        ),
        nonSignedInBuilder: (context) => const SignInPage(),
        adminSignedBuilder: (context) => const AdminHome(),
      ),
    );
  }
}
