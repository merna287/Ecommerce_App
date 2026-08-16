import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(easy.tr(LocaleKeys.mainScreenTitle))),
    );
  }
}
