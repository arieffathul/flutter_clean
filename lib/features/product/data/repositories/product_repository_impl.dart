import 'package:clean_flutter/features/product/data/datasources/product_datasource.dart';
import 'package:clean_flutter/features/product/data/models/product_model.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
import 'package:clean_flutter/features/product/domain/repositories/produk_repositories.dart';
import 'package:dartz/dartz.dart';

class ProdukRepoImpl implements ProdukRepositories {
  //menambahkan ProdukRemoteDataSource
  final ProdukRemoteDataSource produkRemoteDataSource;

  ProdukRepoImpl({required this.produkRemoteDataSource});
  @override
  Future<Either<Exception, void>> addProduk(
      {required ProdukModel produk}) async {
    try {
      final data = await produkRemoteDataSource.addProduk(produk: produk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> deleteProduk({required String id}) async {
    try {
      final data = await produkRemoteDataSource.deleteProduk(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editProduk(
      {required ProdukModel produk}) async {
    try {
      final data = await produkRemoteDataSource.editProduk(produk: produk);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Produk>>> getAllProduk() async {
    try {
      final data = await produkRemoteDataSource.getAllProduk();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Produk>> getProdukById({required String id}) async {
    try {
      final data = await produkRemoteDataSource.getProdukById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}
