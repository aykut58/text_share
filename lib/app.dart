import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_send_app/screens/home_page.dart';

import 'theme/theme_data.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Değişimini dinleyeceğimiz değişkene erişim için
    final watch = context.watch<ThemeProvider>();

    /// 2. Alterantif
    /// final watch = Provider.of<ThemeProvider>(context, listen: true);
    /// [listen: true]: Rebuild için
    return MaterialApp(
      title: 'Flutter Localization Dynamic',
      debugShowCheckedModeBanner: false,

      ///
      theme: watch.isDarkTheme ? ThemeData.dark() : ThemeData.light(),

      ///
      home:  HomePage(),
    );
  }
}
