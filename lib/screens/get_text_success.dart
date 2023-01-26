// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, implementation_imports, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GetTextSuccess extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GetTextSuccess({Key? key,required this.text }) : super(key: key);

  final String text;
 
  @override
  State<GetTextSuccess> createState() => _GetTextSuccessState(text );
}

class _GetTextSuccessState extends State<GetTextSuccess> {
  // ignore: prefer_typing_uninitialized_variables
  var text;
  
  _GetTextSuccessState(this.text );
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold
    (
      // ignore: prefer_const_constructors
     
      body: Center(child: 
      Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          // ignore: prefer_const_constructors
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(text, style: TextStyle(fontSize: 25),),),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: ()
            async {
              await Clipboard.setData(ClipboardData(text: text));
            }, 
            // ignore: prefer_const_constructors
            child: Text("Kopyala"),)
        ],
      ),
      ),
    );
  }
}