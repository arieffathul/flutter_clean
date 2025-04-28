// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String namaCat;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Category(
      {required this.id,
      required this.namaCat,
      required this.deskripsi,
      this.createdAt,
      this.updatedAt});

  // const Produk(
  //     {required this.id,
  //     required this.namaProduk,
  //     required this.harga,
  //     required this.deskripsi});

  @override
  List<Object?> get props {
    return [
      id,
      namaCat,
      deskripsi,
      createdAt,
      updatedAt,
    ];
  }
}
