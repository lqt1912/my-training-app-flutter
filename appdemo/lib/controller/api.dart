// ignore_for_file: unused_catch_clause

import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:html' as html;

String baseUrl = "https://dummyjson.com";


//https://dummyjson.com/todo
//thêm bản ghi
httpGet(url, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var responseGet = await http.get(Uri.parse('$baseUrl$url'), headers: headers);
  if (responseGet.statusCode == 200 && responseGet.headers["content-type"] == 'application/json') {
    try {
      return {"headers": responseGet.headers, "body": json.decode(utf8.decode(responseGet.bodyBytes))};
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {"headers": responseGet.headers, "body": utf8.decode(responseGet.bodyBytes)};
  }
}

//thêm bản ghi
httpPost(url, requestBody, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(Uri.parse("$baseUrl$url".toString()), headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

//cập nhật bản ghi
httpPut(url, requestBody, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.put(Uri.parse('$baseUrl$url'), headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

//xóa bản ghi
httpDelete(url, context) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var response = await http.delete(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {
      //bypass
    }
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}
