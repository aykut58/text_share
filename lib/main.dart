import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:text_send_app/screens/home_page.dart';

import 'app.dart';
import 'theme/theme_data.dart';
import 'utils/box_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<bool>(BoxManager.instance.boxNameTheme);
  runApp(
    ///
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          ///
          create: (context) => ThemeProvider(),
        ),
      ],

      ///
      child:  App(),
    ),
  );
}
