// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final DateTime? lastLogin;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    this.lastLogin,
    this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      name,
      photoUrl,
      lastLogin,
      createdAt,
    ];
  }
}
