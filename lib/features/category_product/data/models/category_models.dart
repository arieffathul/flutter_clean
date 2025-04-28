import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModels extends Category {
  const CategoryModels({
    required super.id,
    required super.namaCat,
    required super.deskripsi,
    super.createdAt,
    super.updatedAt,
  });

  factory CategoryModels.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModels(
      id: doc.id,
      namaCat: data['namaCat'],
      deskripsi: data['deskripsi'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFireStoreAdd() {
    return {
      'namaCat': namaCat,
      'deskripsi': deskripsi,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'namaCat': namaCat,
      'deskripsi': deskripsi,
      // 'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }
}
