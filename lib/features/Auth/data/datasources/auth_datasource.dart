import 'package:clean_flutter/features/Auth/data/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> signInWithEmailAndPassword(String email, String password);
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password);
  Future<UsersModel> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final Box box;

  AuthRemoteDataSourceImplementation(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.box});
  @override
  Future<UsersModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      Box userBox = Hive.box('box');
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
      await userBox.put('uid', credential.user?.uid);
      await userBox.put('name', userDoc.data()!['name']);
      await userBox.put('email', userDoc.data()!['email']);
      await userBox.put('photoUrl', userDoc.data()!['photoUrl']);

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
  Future<void> signOut() async {
    try {
      await box.clear();
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Gagal Logout: $e');
    }
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
