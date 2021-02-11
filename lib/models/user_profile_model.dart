class UserProfile {
  String userId;
  String username;
  String name;
  String firstName;
  String lastName;
  int followersCount;
  int followingCount;
  UserImage image;

  UserProfile.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];

    image = json['profile_image'] != null
        ? UserImage.fromJson(json['profile_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.userId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;

    if (this.image != null) {
      data['profile_image'] = this.image.toJson();
    }
    return data;
  }
}

class UserImage {
  String small;
  String medium;
  String large;

  UserImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;


    return data;
  }
}