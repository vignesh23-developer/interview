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
      accessToken: json['access_token'],
      username: json['user']['username'],
      locations: (json['locations'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList(),
    );
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
}