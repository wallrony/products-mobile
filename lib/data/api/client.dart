import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

Client httpClient = new Client();

class ClientApi {
  String baseUrl = 'http://192.168.1.108:3333/api';

  get(String path) async {
    Response response = await httpClient.get(
      '$baseUrl/$path',
      headers: getBaseHeaders(),
    );

    dynamic jsonResponse = getBody(response);

    return jsonResponse;
  }

  post(String path, dynamic data) async {
    Response response = await httpClient.post(
      '$baseUrl/$path',
      headers: getBaseHeaders(),
      body: jsonEncode(data),
    );

    Map jsonResponse = getBody(response);

    return jsonResponse;
  }

  put(String path, data) async {
    Response response = await httpClient.put(
      '$baseUrl/$path',
      headers: getBaseHeaders(),
      body: jsonEncode(data),
    );

    print(response.body);

    Map jsonResponse = getBody(response);

    return jsonResponse;
  }

  delete(String path) async {
    Response response = await httpClient.delete(
      '$baseUrl/$path',
      headers: getBaseHeaders(),
    );

    Map jsonResponse = getBody(response);

    return jsonResponse;
  }

  getBaseHeaders() {
    Map<String, String> headers = {};

    headers[HttpHeaders.contentTypeHeader] = 'application/json';

    return headers;
  }

  getBody(Response response) {
    String utf8Response = utf8.decode(response.bodyBytes);
    Map jsonResponse = json.decode(utf8Response);

    return jsonResponse;
  }

  getStreamedBody(StreamedResponse response) async {
    String utf8Response = await response.stream.transform(utf8.decoder).first;
    Map jsonResponse = json.decode(utf8Response);

    return jsonResponse;
  }

  MultipartRequest getMultipartRequest(String method, String path) {
    final uri = Uri.parse('$baseUrl/$path');

    final multipartRequest = MultipartRequest(method, uri);

    return multipartRequest;
  }

  _getImageStreamByImage(File image) {
    final stream = new ByteStream(DelegatingStream.typed(image.openRead()));

    return stream;
  }

  getMultipartFile(String fieldName, File image) async {
    final stream = _getImageStreamByImage(image);

    final imageLength = await image.length();

    final multipartFile = new MultipartFile(
      fieldName,
      stream,
      imageLength,
      filename: basename(image.path),
    );

    return multipartFile;
  }
}
