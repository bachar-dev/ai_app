import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  String? apikey;
  Api({@required this.apikey});
  Future<dynamic> get({required String url}) async {
    final Uri uri = Uri.parse(url);
    http.Response response = await http.get(
      uri,
    );
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('error fetching data statuc code ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String url, required Map<String, dynamic> body}) async {
    final Uri uri = Uri.parse(url);
    http.Response response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'raw0data',
        'x-api-key': apikey != null ? '' : apikey.toString(),
      },
    );
    if (kDebugMode) {
      print('test');
    }
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to post data, status code: ${response.statusCode}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    headers.addAll({
      'Content-Type': 'application/json',
    });
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    http.Response response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('failed ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> postWithAudio({
    required String url,
    required String path,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.files.add(
        await http.MultipartFile.fromPath('file', path),
      );
      request.headers['Content-Type'] = 'multipart/form-data';

      var streamedResponse = await request.send();
      print(streamedResponse);
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw Exception('Error uploading audio: $e');
    }
  }
}
