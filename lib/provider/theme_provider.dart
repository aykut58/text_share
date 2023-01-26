import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../utils/box_manager.dart';

/// <ThemeProvider>
/// Sınıfı ChangeNotifier'ten extends et ya da with..
class ThemeProvider with ChangeNotifier {

  ThemeProvider() {
    _isDarkTheme = true;
    _initTheme();
  }

  final Box<bool> _boxTheme = Hive.box<bool>(BoxManager.instance.boxNameTheme);

  /// Variable
  bool _isDarkTheme = false;

  /// Getter: Dili [OKU/GETİR]
  bool get isDarkTheme => _isDarkTheme;

  /// Setter: Dili [DEĞİŞTİR/YENİ DEĞER ATA]
  set setLocale(bool newValue) {
    /// Girilen ile Mevcut değer aynı ise [DEĞİŞİKLİK YAPMA]
    /// yani notifyListeners çalışmasın
    if (newValue == _isDarkTheme) {
      debugPrint(
          'Girilen "$newValue" değeri mevcut "$_isDarkTheme" değeri ile aynı.');
      return;
    }

    /// Değiştirilen yeni bool değerini / tema değerini değişkene [ATA]
    _isDarkTheme = newValue;
    debugPrint('Dil "$_isDarkTheme" olarak değiştirildi');

    /// Tema değişikliğini [BİLDİR]
    /// [state]'in güncellenmesi için
    /// [notifyListeners()] metodunu çağırdık.
    notifyListeners();
  }

    /// Save Theme: Theme değişikliğini Hive ile [KAYDET]
  void _saveTheme(bool newValue) {
    /// Write Box - Dil Kodunu Kutuya [YAZ/KAYDET]
    _boxTheme.put(
      BoxManager.instance.keyLightTheme,
      newValue,
    );

    log('Tema değeri "${_isDarkTheme == true ? 'Light Theme' : 'Dark Theme'}" olarak kaydedildi');
  }
  // Initialize Theme: Uygulama Açıldığında Temayı Yükle
  void _initTheme() {
    /// Read Box - Dil Kodunu Kutudan [OKU/GETİR]
    var _getLightTheme = _boxTheme.get(
      BoxManager.instance.keyLightTheme,
      defaultValue: true,
    );

    /// Kutudaki değerleri _locale değişkenine [ATA]
    _isDarkTheme = _getLightTheme!;

    notifyListeners();
    log(
      'Uygulamanın başlangıç teması: "${_getLightTheme == true ? 'Light Theme' : 'Dark Theme'}"',
    );
  }
}
