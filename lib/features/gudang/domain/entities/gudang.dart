// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:clean_flutter/features/suplier/data/models/suplier_model.dart';

class Gudang extends Equatable {
  final String id;
  final String namaGudang;
  final String alamat;
  final String kapasitas;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? suplierId;
  final SuplierModel? suplier;

  const Gudang({
    required this.id,
    required this.namaGudang,
    required this.alamat,
    required this.kapasitas,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
    this.suplierId,
    this.suplier,
  });

  // const Produk(
  //     {required this.id,
  //     required this.namaProduk,
  //     required this.harga,
  //     required this.deskripsi});

  @override
  List<Object?> get props {
    return [
      id,
      namaGudang,
      alamat,
      kapasitas,
      deskripsi,
      createdAt,
      updatedAt,
      suplierId,
      suplier,
    ];
  }
}
