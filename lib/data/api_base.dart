import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash_app/utils/status_error.dart';
import 'package:unsplash_app/data/constants.dart' as constants;

abstract class ApiBase {
  ApiBase({String defaultUrl, HttpClient client})
      : defaultUrl = defaultUrl ?? constants.defaultUrl,
        client = client ?? http.Client();

  String defaultUrl;
  http.Client client;

  final log = Logger('Data');

  Future<http.Response> post(Uri uri, dynamic body) async {
    log.info(uri.toString());
    var postBody = body;

    if (body is Map) {
      Map params = body;
      postBody = params;
      log.info('postParams: ${params.toString()}');
    } else {
      log.info('postParams: ${postBody?.toString()}');
    }

    final response = await client.post(
      uri,
      body: postBody,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Client-ID ${constants.clientId}'
      },
    ).timeout(Duration(seconds: 20));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw StatusError(response.statusCode, response.body);
    }
  }

  Future<http.Response> get(Uri uri) async {
    log.info(uri.toString());
    final response = await client.get(uri, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Client-ID ${constants.clientId}'
    }).timeout(Duration(seconds: 20));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw StatusError(response.statusCode, response.body);
    }
  }

  Uri createUri(String defaultUrl, String unEncodedPath,
      [Map<String, String> queryParameters]) {
    return Uri.https(defaultUrl, '$unEncodedPath', queryParameters);
  }
}
