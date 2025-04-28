import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TypeModels extends TypeProduct {
  const TypeModels({
    required super.id,
    required super.namatype,
    required super.deskripsi,
    super.createdAt,
    required super.updatedAt,
  });

  factory TypeModels.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TypeModels(
        id: doc.id,
        namatype: data['namaType'],
        deskripsi: data['deskripsi'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toFireStoreAdd() {
    return {
      'namaType': namatype,
      'deskripsi': deskripsi,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'namaType': namatype,
      'deskripsi': deskripsi,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
