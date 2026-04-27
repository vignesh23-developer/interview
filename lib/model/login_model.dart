import 'dart:convert';

class LoginResponse {
  final String accessToken;
  final String username;
  final List<LocationModel> locations;

  LoginResponse({
    required this.accessToken,
    required this.username,
    required this.locations,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      username: json['user']?['username'] ?? '',
      locations: (json['locations'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList(),
    );
  }

  static String locationsToJson(List<LocationModel> locations) {
    return jsonEncode(locations.map((e) => e.toJson()).toList());
  }

   static List<LocationModel> locationsFromJson(String str) {
    final List data = jsonDecode(str);
    return data.map((e) => LocationModel.fromJson(e)).toList();
  }
}

class LocationModel {
  final int id;
  final String name;
  final String city;
  final String state;
  final String country;
  final String? image;

  LocationModel({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    required this.country,
    this.image,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      image: json['media']?['display_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "state": state,
      "country": country,
      "image": image,
    };
  }
}