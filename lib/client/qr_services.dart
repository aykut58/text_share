import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:text_send_app/core/log_extensions.dart';


class QRService {
  ///
  Future<String> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#6666ff',
        "İptal",
        true,
        ScanMode.QR,
      );
      return barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      logError(
        "Barkod Okunamadı",
      );
      return barcodeScanRes;
    }
  }
}
