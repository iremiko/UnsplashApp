import 'dart:convert';
import 'dart:io';
import 'package:unsplash_app/data/api_base.dart';
import 'package:unsplash_app/models/photos_model.dart';

class ApiData extends ApiBase {
  String photosPath = 'photos';
  String searchPath = 'search';

  ApiData({String defaultUrl, HttpClient client})
      : super(defaultUrl: defaultUrl, client: client);

  Future<List<Photos>> getPhotos(int page, {pageSize: 20}) async {
    Uri uri = createUri(defaultUrl, '/$photosPath', {
      'page': page.toString(),
      'per_page': pageSize.toString(),
    });

    final response = await get(uri);
    final jsonDecoded = json.decode(response.body);
    final result = (jsonDecoded as List)
        .map((e) => Photos.fromJson(e))
        .toList();
    return result;
  }
}
