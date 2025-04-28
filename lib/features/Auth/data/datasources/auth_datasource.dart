import 'package:clean_flutter/features/Auth/data/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> signInWithEmailAndPassword(String email, String password);
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password);
  Future<UsersModel> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImplementation({required this.firebaseAuth});
  @override
  Future<UsersModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userModel = UsersModel(
        id: credential.user!.uid,
        email: email,
        name: credential.user!.displayName ?? '',
        createdAt: credential.user!.metadata.creationTime,
        lastLogin: credential.user!.metadata.lastSignInTime,
        photoUrl: credential.user!.photoURL ?? '',
      );
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .get();
      if (!userDoc.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.id)
            .set(userModel.toMap());
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .update({'lastLogin': userModel.lastLogin});

      return userModel;

      // return UsersModel.fromJson(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("Password lemah");
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      throw Exception("Error lainnya");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UsersModel> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userModel = UsersModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        createdAt: credential.user!.metadata.creationTime,
        lastLogin: credential.user!.metadata.lastSignInTime,
        photoUrl: credential.user!.photoURL ?? '',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());
      return userModel;
      // return UsersModel.fromJson(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("Password lemah");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("Email sudah terpakai");
      }
      throw Exception("Error lainnya");
    } catch (e) {
      throw Exception(e);
    }
  }
}
