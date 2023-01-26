// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, unnecessary_import, duplicate_ignore, implementation_imports

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:text_send_app/core/log_extensions.dart';
import 'package:text_send_app/request/text_get_request.dart';
// ignore: unused_import
import 'package:text_send_app/screens/get_text_screen.dart';
import 'package:text_send_app/screens/get_text_success.dart';

import '../client/qr_services.dart';
import '../client/text_client.dart';

class GetTextScreens extends StatefulWidget {
  const GetTextScreens({super.key});

  @override
  State<GetTextScreens> createState() => _GetTextScreensState();
}

class _GetTextScreensState extends State<GetTextScreens> {
  TextEditingController idController = TextEditingController();
  TextClient textClient = TextClient();
  late final QRService qrService;

  @override
  void initState() 
  {
    super.initState();
     qrService = QRService();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(title: Text("Metin Görüntüleme"),
      ),
      body: Center
      (
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            // IconButton(onPressed: () 
            // async {
            //   // ignore: unused_local_variable
            //   final qrResult = await qrService.scanQR();
            //   if(qrResult.contains("-1"))
            //   {
            //     print("hata verdi");
            //   }
            //   else 
            //   {
            //     print("sıkıntı yok");
            //   }
            // }, 
            // icon: Icon(Icons.qr_code_outlined, size: 50,)),
            OutlineGradientButton(
              onTap: () async
              {
                final qrResult = await qrService.scanQR();
                if(qrResult.contains("-1"))
                {
                  //qr okunmadı
                }
                else
                {
                  TextGetRequest textGetRequest = TextGetRequest();
                  textGetRequest.id = int.tryParse(qrResult);
                  final response = await textClient.textGet(textGetRequest);
                  if(response.statusCode == 200)
                  {
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => GetTextSuccess(text:"${response.text}")));
                  }
                  else if (response.statusCode == 404)
                  {
                    // ignore: avoid_single_cascade_in_expression_statements
                    AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'İşlem Başarısız',
                                desc: "Veri Bulunamadı.",
                                btnOkText: "Tamam",
                                btnOkOnPress: () {},
                                )..show();
                  }
                  else 
                  {

                  }
                  
                }

              },
              // ignore: sort_child_properties_last
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 9,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Icon(Icons.qr_code, color: Colors.black, size: 30),
                    SizedBox(height: 5,),
                    Text('Qr İle Getir', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
                  ],
                ),
              ),
              gradient: LinearGradient(
                // ignore: prefer_const_literals_to_create_immutables
                colors: [Colors.blue, Colors.black],
                begin: Alignment(-1, -1),
                end: Alignment(2, 2),
              ),
              strokeWidth: 4,
              padding: EdgeInsets.zero,
              radius: Radius.circular(26),
            ),
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.all(5),
            child: 
            TextFormField(
              controller: idController,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
            labelText: "ID Giriniz",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 103, 97, 97))
              ),
              )
          ),
          ),
            ElevatedButton(
              child: const Text("Getir"),
              onPressed: () async
              {
                
                TextGetRequest textGetRequest = TextGetRequest();
                textGetRequest.id=int.tryParse(idController.text);
                
                final response = await textClient.textGet(textGetRequest);
                
                if(response.statusCode == 200) 
                {
                  
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => GetTextSuccess(text:"${response.text}")));
                  logInfo(response.text.toString());
                  // veri gelmiş
                }
                else if (response.statusCode == 404)
                {
                  AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'İşlem Başarısız',
                                desc: "Veri Bulunamadı.",
                                btnOkText: "Tamam",
                                btnOkOnPress: () {},
                                )..show();
                  // bulunamadı
                }
                else 
                {
                  // hata
                }
              }
              )
          ],
          ) ,
      ),
    );
  }
}