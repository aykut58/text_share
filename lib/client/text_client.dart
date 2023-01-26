import 'dart:convert';


import 'package:text_send_app/core/log_extensions.dart';
import 'package:text_send_app/request/text_get_request.dart';
import 'package:text_send_app/request/text_save_request.dart';
import 'package:text_send_app/response/text_get_response.dart';

import '../response/text_save_response.dart';
import 'package:http/http.dart' as http;

class TextClient
{
  // 'http://167.172.166.69:8080/api/text' gönderme
  // 'http://167.172.166.69:8080/api/text/1' okuma
  final baseUrl="http://167.172.166.69:8080";
  final path="/api/text";
  final requestHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'};
  


  //textsaveresponse
  Future<TextSaveResponse> textSave(TextSaveRequest textSaveRequest)
  async {

    
    final url = Uri.parse(baseUrl + path);
    logInfo("tam url : $url");
    final response = await http.post(url , headers: requestHeaders , body: jsonEncode(textSaveRequest));
    final responseBody = response.body;
    final map = jsonDecode(responseBody);
    TextSaveResponse textSaveResponse = TextSaveResponse();
    textSaveResponse.statusCode=response.statusCode;
    logInfo("response : ${response.body}");
    //if 201 
    if(response.statusCode == 201)
     {
      //textSaveResponse.message=map["message"];
      textSaveResponse.id=map["id"];
     }
    return Future.value(textSaveResponse);
  }






  Future<TextGetResponse> textGet(TextGetRequest textGetRequest) async 
  {

    final url = Uri.parse("$baseUrl$path/${textGetRequest.id}"); 
    logInfo("tam url : $url ");
    final response = await http.get(url,headers: {'Content-Type': 'text/plain; charset=utf-8'});
    String responseBody= utf8.decode(response.bodyBytes);
    
    responseBody = responseBody.replaceAll('Ã¶', 'ö').replaceAll('Ã§', 'ç').replaceAll('Ã¼', 'ü');
    //final responseBody = response.body;
    final map = jsonDecode(responseBody);
    TextGetResponse textGetResponse = TextGetResponse();
    textGetResponse.statusCode=response.statusCode;
    
    if(textGetResponse.statusCode == 200)
    {
      textGetResponse.text=map["text"];
      logInfo("responseText:  ${textGetResponse.text.toString()}");
    }
    else
    {
      textGetResponse.text=null;
    }
    
    return Future.value(textGetResponse);
  }
  
  
  //getbyid
}