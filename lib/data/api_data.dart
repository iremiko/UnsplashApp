import 'dart:convert';
import 'dart:io';
import 'package:unsplash_app/data/api_base.dart';
import 'package:unsplash_app/models/photos_model.dart';
import 'package:unsplash_app/models/user_profile_model.dart';

class ApiData extends ApiBase {
  String mePath = 'me';
  String photosPath = 'photos';
  ApiData({String defaultUrl, HttpClient client})
      : super(defaultUrl: defaultUrl, client: client);

  Future<UserProfile> getMe() async {
    Uri uri = createUri(defaultUrl,
        '/$mePath');

    final response = await get(uri);
    final result =
    UserProfile.fromJson(json.decode(response.body));
    return result;
  }
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

  Future<Photos> getPhotoDetail(String photoId) async {
    Uri uri = createUri(defaultUrl,
        '/$photosPath/$photoId');

    final response = await get(uri);
    final result =
    Photos.fromJson(json.decode(response.body));
    return result;
  }
}
