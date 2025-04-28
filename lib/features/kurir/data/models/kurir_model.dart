import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
import 'package:clean_flutter/features/kurir/domain/entities/kurir.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KurirModel extends Kurir {
  const KurirModel(
      {required super.id,
      required super.namaKurir,
      required super.noTelp,
      required super.email,
      required super.alamat,
      super.createdAt,
      super.updatedAt,
      super.gudangId,
      super.gudang});

  static Future<KurirModel> fromFirestore(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;

    GudangModel? gudang;
    if (data['gudangId'] != null && data['gudangId']!.toString().isNotEmpty) {
      final gudangDoc = await FirebaseFirestore.instance
          .collection('gudangs')
          .doc(data['gudangId'])
          .get();

      if (gudangDoc.exists) {
        gudang = await GudangModel.fromFirestore(gudangDoc);
      }
    }

    return KurirModel(
        id: doc.id,
        namaKurir: data['namaKurir'],
        noTelp: data['noTelp'],
        email: data['email'],
        alamat: data['alamat'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: data['updatedAt'] != null
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
        gudangId: data['gudangId'] ?? '',
        gudang: gudang);
  }

  Map<String, dynamic> toFireStoreAdd() {
    return {
      'namaKurir': namaKurir,
      'noTelp': noTelp,
      'email': email,
      'alamat': alamat,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
      'gudangId': gudangId ?? '',
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'namaKurir': namaKurir,
      'noTelp': noTelp,
      'email': email,
      'alamat': alamat,
      // 'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
      'gudangId': gudangId ?? ''
    };
  }
}
