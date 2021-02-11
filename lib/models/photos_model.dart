import 'package:unsplash_app/models/photos_url_model.dart';
import 'package:unsplash_app/models/user_profile_model.dart';

class Photos {
  String id;
  String description;
  PhotosUrl photosUrl;
  UserProfile userProfile;

  Photos({this.id, this.description, this.photosUrl, this.userProfile});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];

    photosUrl = json['urls'] != null ? PhotosUrl.fromJson(json['urls']) : null;
    userProfile =
        json['user'] != null ? UserProfile.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;

    if (this.photosUrl != null) {
      data['urls'] = this.photosUrl.toJson();
    }
    if (this.userProfile != null) {
      data['user'] = this.userProfile.toJson();
    }
    return data;
  }
}
