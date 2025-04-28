import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/users.dart';

class UsersModel extends UserEntity {
  const UsersModel(
      {required super.id,
      required super.email,
      super.name,
      super.lastLogin,
      super.createdAt,
      super.photoUrl});
  factory UsersModel.fromJson(User user) {
    return UsersModel(
      id: user.uid,
      email: user.email!,
      name: user.displayName,
      lastLogin: user.metadata.lastSignInTime!,
      createdAt: user.metadata.creationTime!,
      photoUrl: user.photoURL ?? '',
    );
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'lastLogin': lastLogin,
        'createdAt': createdAt,
        'photoUrl': photoUrl,
      };
}
