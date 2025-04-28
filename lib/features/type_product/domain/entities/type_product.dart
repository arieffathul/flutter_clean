// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TypeProduct extends Equatable {
  final String id;
  final String namatype;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime updatedAt;

  const TypeProduct(
      {required this.id,
      required this.namatype,
      required this.deskripsi,
      this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props {
    return [
      id,
      namatype,
      deskripsi,
      createdAt,
      updatedAt,
    ];
  }
}
