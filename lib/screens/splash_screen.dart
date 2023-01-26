// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:text_send_app/screens/get_text_screen.dart';
import 'package:text_send_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İkisini De Dene Tarafını Seç"),
      ),
      body: Center(
        
        child: Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            
            ElevatedButton(
              child: Text("Metin Yolla"),
              onPressed: () 
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage() ));
            }
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              child: Text("Metin Al"),
              onPressed: () 
              {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => GetTextScreens() ));
              }, 
              
              )
          ],
        )
        ),
    );
  }
}