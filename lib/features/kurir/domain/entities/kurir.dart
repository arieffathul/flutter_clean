// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';

class Kurir extends Equatable {
  final String id;
  final String namaKurir;
  final String noTelp;
  final String email;
  final String alamat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? gudangId;
  final GudangModel? gudang;

  const Kurir({
    required this.id,
    required this.namaKurir,
    required this.noTelp,
    required this.email,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
    this.gudangId,
    this.gudang,
  });

  @override
  List<Object?> get props {
    return [
      id,
      namaKurir,
      noTelp,
      email,
      alamat,
      createdAt,
      updatedAt,
      gudangId,
      gudang,
    ];
  }
}
