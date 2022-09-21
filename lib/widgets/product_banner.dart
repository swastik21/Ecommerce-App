import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class Productbanner extends StatelessWidget {
  Productbanner({Key? key}) : super(key: key);
  final shoes = jsonDecode(FirebaseRemoteConfig.instance.getString('shoes'));

  @override
  Widget build(BuildContext context) {
    print(shoes[0].runtimeType);
    return Container(
        height: 175,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 255, 123, 0), Colors.black]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "New Release",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  "Cool ${shoes["2"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  presetFontSizes: const [20, 30],
                ),
              ],
            ),
            Image.asset(
              "assets/img/shoe.png",
              width: 125,
            )
          ],
        ));
  }
}
