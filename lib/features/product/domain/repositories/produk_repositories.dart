import 'package:clean_flutter/features/product/data/models/product_model.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProdukRepositories {
  //future tipe data bisa banyak
  Future<Either<Exception, List<Produk>>> getAllProduk();
  Future<Either<Exception, Produk>> getProdukById({required String id});
  Future<Either<Exception, void>> addProduk({required ProdukModel produk});
  Future<Either<Exception, void>> editProduk({required ProdukModel produk});
  Future<Either<Exception, void>> deleteProduk({required String id});
}
