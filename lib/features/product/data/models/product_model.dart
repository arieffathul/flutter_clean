// import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
// import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
// import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukModel extends Produk {
  const ProdukModel({
    required super.id,
    super.categoryId,
    super.typeId,
    super.gudangId,
    required super.namaProduk,
    required super.harga,
    required super.deskripsi,
    super.createdAt,
    super.updatedAt,
    super.category,
    super.type,
    super.gudang,
  });

  factory ProdukModel.fromFireStore(
    DocumentSnapshot doc,
    Category? category,
    TypeProduct? type,
    Gudang? gudang,
  ) {
    final data = doc.data() as Map<String, dynamic>;

    return ProdukModel(
      id: doc.id,
      namaProduk: data['namaProduk'],
      categoryId: data['categoryId'] ?? '',
      typeId: data['typeId'] ?? '',
      gudangId: data['gudangId'] ?? '',
      harga: data['harga'],
      deskripsi: data['deskripsi'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      category: category,
      type: type,
      gudang: gudang,
    );
  }

  // factory ProdukModel.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return ProdukModel(
  //     id: doc.id,
  //     categoryId: data['categoryId'] ?? '',
  //     typeId: data['typeId'] ?? '',
  //     gudangId: data['gudangId'] ?? '',
  //     namaProduk: data['namaProduk'],
  //     harga: data['harga'],
  //     deskripsi: data['deskripsi'],
  // createdAt: data['createdAt'] != null
  //     ? (data['createdAt'] as Timestamp).toDate()
  //     : null,
  // updatedAt: data['updatedAt'] != null
  //     ? (data['updatedAt'] as Timestamp).toDate()
  //     : null,
  //   );
  // }

  Map<String, dynamic> toFireStore() {
    final data = {
      'namaProduk': namaProduk,
      'categoryId': categoryId ?? '',
      'typeId': typeId ?? '',
      'gudangId': gudangId ?? '',
      'harga': harga,
      'deskripsi': deskripsi,
      // 'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt!)
    };
    // Hanya tambahkan 'createdAt' jika ada perubahan
    if (createdAt != null) {
      data['createdAt'] = Timestamp.fromDate(createdAt!);
    }

    return data;
  }
}
