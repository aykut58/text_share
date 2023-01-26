import 'package:flutter/foundation.dart';

/// <ThemeProvider>
/// Sınıfı ChangeNotifier'ten extends et ya da with..
class ThemeProvider with ChangeNotifier {
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
}
