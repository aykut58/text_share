// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TextSendSuccess extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
   TextSendSuccess({Key? key,required this.id}) : super(key: key);

  final String id;
  @override
  // ignore: no_logic_in_create_state
  State<TextSendSuccess> createState() => _TextSendSuccessState(id);
}

class _TextSendSuccessState extends State<TextSendSuccess> {
  // ignore: prefer_typing_uninitialized_variables
  var id;
  
  _TextSendSuccessState( this.id );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Metin Bilgileri"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          
          Text("Metin ID'si : " + id.toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
          const SizedBox(height: 10,),
          Card(child: 
          QrImage(
            data: id.toString(),
            version: QrVersions.min,
            size: 150,
          ),)
        ]
        ),
        ),
    );
  }
}