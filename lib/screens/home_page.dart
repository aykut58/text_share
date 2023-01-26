// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, unused_local_variable, use_build_context_synchronously, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:text_send_app/client/text_client.dart';
import 'package:text_send_app/core/extension/string_extension.dart';
import 'package:text_send_app/core/locale_keys.g.dart';
import 'package:text_send_app/core/log_extensions.dart';
import 'package:text_send_app/core/text/locale_text.dart';
import 'package:text_send_app/request/text_save_request.dart';
import 'package:text_send_app/screens/setting.dart';
import 'package:text_send_app/screens/text_send_success.dart';

import '../client/share_service.dart';
import 'get_text_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final TextEditingController textController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();
  
  TextClient textClient = TextClient();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  String _sharedText = "";
  @override
  void initState() {
    super.initState();

    // Create the share service
    
      // App çalışmakta iken paylaşılan veriyi alıyoruz.
    
  }

  void _handleSharedData(String sharedData) {
    setState(() {
      
       _sharedText = sharedData;
    });
  }


  @override
  Widget build(BuildContext context) {
    


    final dravwer = Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 60,
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text("Metin Alma"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetTextScreens() ));
          },
        ),
         ListTile(
          leading: Icon(Icons.settings),
          title: LocaleText(text: "Ayarlar"), 
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ThemePage() ));
          },
        ),
        
      ],
    ),
    );




    return Scaffold
    (
      endDrawer: dravwer,
      appBar: AppBar(title: Text("Metin Gönderme"),
      ),
      body: Center
      (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
        [
          
          Text("Metin Geçelilik Tarih Ve Saatini Seçin", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () 
                {
                  
                showDatePicker(
                context: context, 

                initialDate: DateTime.now(), 
                firstDate: DateTime(2001), 
                lastDate: DateTime(2222)).then((value) =>  setState (() {dateTime = value;})); 
                
                
                }, 
                child: Text("Tarih Seçin"),
                ),
                SizedBox(width: 20,),
                ElevatedButton(onPressed: () 
                {
                  showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) => setState (() { timeOfDay = value;})); 
                }, child: Text("Saat Seçin"),
                ),
            ],
          ),
          SizedBox(height: 10,),
          Text("Seçili Tarih Ve Saat", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              if(dateTime != null) 
                Text(" ${dateTime!.day}/${dateTime!.month}/${dateTime!.year} - ", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
              if(timeOfDay !=null)
                Text("${timeOfDay!.hour}:${timeOfDay!.minute}", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),)
              //Text(" ${dateTime!.day}/${dateTime!.month}/${dateTime!.year} - ", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
              // Text("${timeOfDay!.hour}:${timeOfDay!.minute}", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),)
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(5),
            child:  Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: globalKey,
              child: Column(
                children: 
                [ 
                  TextFormField
                  (
                    controller: textController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    validator: FormFieldValidator().isNotEmpty,
                    style: TextStyle(fontSize: 20),
                    maxLines: 3,
                        decoration: InputDecoration(
                        labelText: "Metin Giriniz",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color.fromARGB(255, 103, 97, 97))
                        ),
                        )
                  ),
                  ElevatedButton(onPressed: () async
              {
                TextSaveRequest textSaveRequest = TextSaveRequest();
                //textRequest.dateTime=2025-01-03T07:16:43.183;

                if( dateTime == null || timeOfDay == null) 
                {
                   // ignore: avoid_single_cascade_in_expression_statements
                   AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Hata!!',
                      desc: "Tarih Seçimi Yapmanız Gerekir",
                      btnOkOnPress: () {},
                      )..show();
                }
                else 
                {
                        if(globalKey.currentState!.validate()) 
                        {
                          String? formattedDate; 
                          formattedDate="${DateFormat('yyyy-MM-dd').format(dateTime!)}T${timeOfDay!.hour}:${timeOfDay!.minute}";
                          textSaveRequest.text=textController.text;
                          textSaveRequest.dateTime=formattedDate;
                          logInfo("Text: ${textSaveRequest.text}");
                          logInfo("Tarih: ${textSaveRequest.dateTime}");
                          final response = await textClient.textSave(textSaveRequest);
                          logInfo("response: ${response.statusCode}");
                            if(response.statusCode ==201)
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TextSendSuccess(id:"${response.id}")));
                              //işlem başarılı
                            }
                            else
                            {
                              // ignore: avoid_single_cascade_in_expression_statements
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'İşlem Başarısız',
                                desc: response.statusCode.toString(),
                                btnOkText: "Tamam",
                                btnOkOnPress: () {},
                                )..show();
                              //işlem başarısız
                            }
                        }
                        else 
                        {
                          print("Boş Alanları Doldurun");
                        }
                }
                
              }, 
              child: const Text("Gönder")),
                ]),
            ),
          ),  
        ]
        ),
      ),
    );
  }
}

class FormFieldValidator 
{
  String? isNotEmpty(String? data) 
  {
    return (data?.isNotEmpty ?? false) ? null : "Boş Geçilemez";
  }
}