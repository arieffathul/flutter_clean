import 'package:clean_flutter/features/suplier/domain/entities/suplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuplierModel extends Suplier {
  const SuplierModel({
    required super.id,
    required super.namaSuplier,
    required super.noTelp,
    required super.email,
    required super.alamat,
    super.createdAt,
    super.updatedAt,
  });

  factory SuplierModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SuplierModel(
      id: doc.id,
      namaSuplier: data['namaSuplier'],
      noTelp: data['noTelp'],
      email: data['email'],
      alamat: data['alamat'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFireStoreAdd() {
    return {
      'namaSuplier': namaSuplier,
      'noTelp': noTelp,
      'email': email,
      'alamat': alamat,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'namaSuplier': namaSuplier,
      'noTelp': noTelp,
      'email': email,
      'alamat': alamat,
      // 'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }
}
