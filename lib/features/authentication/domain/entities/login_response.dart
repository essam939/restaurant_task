class LoginResponse {
 final Client client;
  final String accessToken;
  final String tokenType;
  final int expiresIn;


  const LoginResponse({
    required this.client,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client': client.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
    }
}
class Client {
  final int id;
  final String name;
  final String phone;
  const Client({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
    };
  }

}