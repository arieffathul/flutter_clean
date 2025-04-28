import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/suplier/data/models/suplier_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GudangModel extends Gudang {
  const GudangModel(
      {required super.id,
      required super.namaGudang,
      required super.alamat,
      required super.kapasitas,
      required super.deskripsi,
      super.createdAt,
      super.updatedAt,
      super.suplierId,
      super.suplier});

  // factory GudangModel.fromFirestore(DocumentSnapshot doc) {
  static Future<GudangModel> fromFirestore(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;

    // Jika suplierid ada, maka ambil datanya
    SuplierModel? suplier;
    if (data['suplierId'] != null && data['suplierId']!.toString().isNotEmpty) {
      final suplierDoc = await FirebaseFirestore.instance
          .collection('supliers')
          .doc(data['suplierId'])
          .get();

      if (suplierDoc.exists) {
        suplier = SuplierModel.fromFirestore(suplierDoc);
      }
    }

    return GudangModel(
        id: doc.id,
        namaGudang: data['namaGudang'],
        alamat: data['alamat'],
        kapasitas: data['kapasitas'],
        deskripsi: data['deskripsi'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: data['updatedAt'] != null
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
        suplierId: data['suplierId'] ?? '',
        suplier: suplier);
  }

  Map<String, dynamic> toFireStoreAdd() {
    return {
      'namaGudang': namaGudang,
      'alamat': alamat,
      'kapasitas': kapasitas,
      'deskripsi': deskripsi,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
      'suplierId': suplierId
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'namaGudang': namaGudang,
      'alamat': alamat,
      'kapasitas': kapasitas,
      'deskripsi': deskripsi,
      // 'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
      'suplierId': suplierId ?? ''
    };
  }
}
