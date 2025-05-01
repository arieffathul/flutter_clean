import 'package:clean_flutter/features/keranjang/data/models/keranjang_model.dart';
import 'package:clean_flutter/features/keranjang/domain/entities/keranjang.dart';
import 'package:dartz/dartz.dart';

abstract class KeranjangRepo {
  Future<Either<Exception, List<Keranjang>>> getAllkeranjang();
  Future<Either<Exception, Keranjang>> getkeranjangById({required String id});
  Future<Either<Exception, void>> addKeranjang(
      {required KeranjangModel keranjang});
  Future<Either<Exception, void>> editKeranjang(
      {required KeranjangModel keranjang});
  Future<Either<Exception, void>> deleteKeranjang({required String id});
}
