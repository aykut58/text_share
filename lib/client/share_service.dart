// import 'package:flutter/services.dart';

// // Bu servis işletim sistemi ile konuşarak uygulamaya birşey gönderildiğinde ayağa // kalkar.
// class ShareService {
//   void Function(String)? onDataReceived;

//   ShareService() {
//     // Eğer yapılan paylaşım, uygulamamızı resumed etmişse 
//     // uygulamayla paylaşılmış bir data varmı kontrol ederiz.
//     SystemChannels.lifecycle.setMessageHandler((msg) async {
//       if (msg?.contains("resumed") ?? false) {
//         getSharedData().then((String data) {
//           // Bizimle birşey paylaşılmadığını gördük
//           if (data.isEmpty) {
//             return;
//           }

//           // Bizimle birşey paylaşıldığını gördük ve bizi dinleyenlere bildirdik.
//           onDataReceived?.call(data);
//         });
//       }
//       return;
//     });
//   }

//   // Platformumuza, bizimle paylaşılmak istenen datayı bize iletmesini söylüyoruz. 
//   Future<String> getSharedData() async {
//     return await MethodChannel('com.tnorbury.flutterSharingTutorial')
//             .invokeMethod("getSharedData") ??
//         "";
//   }
// }