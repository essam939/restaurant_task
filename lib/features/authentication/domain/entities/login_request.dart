import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String phone;
  final String password;

  const LoginRequest({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'company_id': 3
    };
  }
}