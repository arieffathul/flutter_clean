// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Suplier extends Equatable {
  final String id;
  final String namaSuplier;
  final String noTelp;
  final String email;
  final String alamat;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Suplier(
      {required this.id,
      required this.namaSuplier,
      required this.noTelp,
      required this.email,
      required this.alamat,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props {
    return [
      id,
      namaSuplier,
      noTelp,
      email,
      alamat,
      createdAt,
      updatedAt,
    ];
  }
}
