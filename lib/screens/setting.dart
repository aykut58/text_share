import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_data.dart';


class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Değişimini dinleyeceğimiz [Değişkene] erişim için
    final watch = context.watch<ThemeProvider>();

    /// Yeni değer ataması yapacağımız [Metota] erişim için
    final read = context.read<ThemeProvider>();

    ///
    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
           [

            // ignore: prefer_const_constructors
            Text(
              "Koyu Tema", style: const TextStyle(fontSize: 20),
            ),
            Switch.adaptive(
              value: watch.isDarkTheme,
              onChanged: (value) {
                /// Yeni değer olarak isDarkTheme'ni atıyoruz<
                read.setLocale = value;
              },
            ),
           ],
           )
          ],
        ),
      ),
    );
  }
}
