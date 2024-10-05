import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({
    super.key,
  });

  @override
  State createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  void onBarcodeScan(BarcodeCapture capture) {
    if (!mounted) {
      return;
    }
    if (capture.barcodes.length != 1) {
      return;
    }
    final data = capture.barcodes.firstOrNull?.rawValue;
    if (data == null) {
      return;
    }
    debugPrint("Scanned: $data");
    passData(data);
  }

  void passData(String data) {
    if (mounted) {
      Navigator.pop(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.scanner_title.tr()),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          formats: [
            BarcodeFormat.qrCode,
            BarcodeFormat.ean13,
            BarcodeFormat.ean8,
            BarcodeFormat.codebar,
          ],
        ),
        onDetect: onBarcodeScan,
        overlay: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: SizedBox(
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
