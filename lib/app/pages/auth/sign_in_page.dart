import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: const [
        EmailProviderConfiguration(),
      ],
      footerBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "By signing in, you agree to our terms and conditions",
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}
