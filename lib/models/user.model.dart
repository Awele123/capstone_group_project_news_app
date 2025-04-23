import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? bearerToken; // Added bearerToken field

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.bearerToken, // Added bearerToken to constructor
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'], // Corrected the 'username' to 'name'
      email: json['email'],
      bearerToken: json[
          'bearer_token'], // Assuming the API sends this field as 'bearer_token'
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bearer_token': bearerToken, // Include bearerToken in the JSON
    };
  }

  @override
  List<Object?> get props =>
      [id, name, email, bearerToken]; // Include bearerToken in the props
}
