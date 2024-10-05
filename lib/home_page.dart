import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final size = 128.0;

  void onScanPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ScannerPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(LocaleKeys.app_name.tr()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onScanPressed,
        child: const Icon(Icons.qr_code_2),
      ),
    );
  }
}
