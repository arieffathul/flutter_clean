// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:equatable/equatable.dart';

// import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
// import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
// import 'package:clean_flutter/features/type_product/data/models/type_models.dart';

class Produk extends Equatable {
  final String id;
  final String? categoryId;
  final String? typeId;
  final String? gudangId;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final Category? category;
  final TypeProduct? type;
  final Gudang? gudang;

  const Produk(
      {required this.id,
      this.categoryId,
      this.typeId,
      this.gudangId,
      required this.namaProduk,
      required this.harga,
      required this.deskripsi,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.type,
      this.gudang});

  @override
  List<Object?> get props {
    return [
      id,
      categoryId,
      typeId,
      gudangId,
      namaProduk,
      harga,
      deskripsi,
      createdAt,
      updatedAt,
      category,
      type,
      gudang,
    ];
  }
}
