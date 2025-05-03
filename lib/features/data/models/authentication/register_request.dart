import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  final String name;
  final String email;
  final String noHandphone;
  final String address;
  final String password;

  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.noHandphone,
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'noHandphone': noHandphone,
      'address': address,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [name, email, noHandphone, address, password];
}
