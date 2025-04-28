import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/product/data/models/product_model.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProdukRemoteDataSource {
  Future<List<Produk>> getAllProduk();
  Future<Produk> getProdukById({required String id});
  // void tidak ada pengembalian
  Future<void> addProduk({required ProdukModel produk});
  Future<void> editProduk({required ProdukModel produk});
  Future<void> deleteProduk({required String id});
}

class ProdukRemoteDataSourceImplementation implements ProdukRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  ProdukRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addProduk({required ProdukModel produk}) async {
    await firebaseFirestore.collection('produks').add(produk.toFireStore());
  }

  @override
  Future<void> deleteProduk({required String id}) async {
    await firebaseFirestore.collection('produks').doc(id).delete();
  }

  @override
  Future<void> editProduk({required ProdukModel produk}) async {
    await firebaseFirestore
        .collection('produks')
        .doc(produk.id)
        .update(produk.toFireStore());
  }

  @override
  Future<List<Produk>> getAllProduk() async {
    final data = await firebaseFirestore.collection('produks').get();
    return Future.wait(data.docs.map((e) async {
      final Map<String, dynamic>? produkData =
          e.data() as Map<String, dynamic>?;
      if (produkData == null) {
        throw Exception('Produk data kosong');
      }
      Category? category;
      if (produkData['categoryId'] != null &&
          produkData['categoryId'].toString().isNotEmpty) {
        final categoryDoc = await FirebaseFirestore.instance
            .collection('categorys')
            .doc(produkData['categoryId'])
            .get();

        if (categoryDoc.exists) {
          category = CategoryModels.fromFirestore(categoryDoc);
        }
      }

      TypeProduct? type;
      if (produkData['typeId'] != null &&
          produkData['typeId']!.toString().isNotEmpty) {
        final typeDoc = await FirebaseFirestore.instance
            .collection('types')
            .doc(produkData['typeId'])
            .get();
        if (typeDoc.exists) {
          type = TypeModels.fromFirestore(typeDoc);
        }
      }

      Gudang? gudang;
      if (produkData['gudangId'] != null &&
          produkData['gudangId']!.toString().isNotEmpty) {
        final gudangDoc = await FirebaseFirestore.instance
            .collection('gudangs')
            .doc(produkData['gudangId'])
            .get();
        if (gudangDoc.exists) {
          gudang = await GudangModel.fromFirestore(gudangDoc);
        }
      }
      return ProdukModel.fromFireStore(e, category, type, gudang);
    })
        // data.docs.map((e) => ProdukModel.fromFireStore(e)),
        );
    // return data.docs
    //     .map(
    //       (e) => ProdukModel.fromFirestore(e),
    //     )
    //     .toList();
  }

  @override
  Future<Produk> getProdukById({required String id}) async {
    final data = await firebaseFirestore.collection('produks').doc(id).get();

    Category? category;
    if (data['categoryId'] != null &&
        data['categoryId'].toString().isNotEmpty) {
      final categoryDoc = await FirebaseFirestore.instance
          .collection('categorys')
          .doc(data['categoryId'])
          .get();

      if (categoryDoc.exists) {
        category = CategoryModels.fromFirestore(categoryDoc);
      }
    }

    TypeProduct? type;
    if (data['typeId'] != null && data['typeId']!.toString().isNotEmpty) {
      final typeDoc = await FirebaseFirestore.instance
          .collection('types')
          .doc(data['typeId'])
          .get();
      if (typeDoc.exists) {
        type = TypeModels.fromFirestore(typeDoc);
      }
    }

    Gudang? gudang;
    if (data['gudangId'] != null && data['gudangId']!.toString().isNotEmpty) {
      final gudangDoc = await FirebaseFirestore.instance
          .collection('gudangs')
          .doc(data['gudangId'])
          .get();
      if (gudangDoc.exists) {
        gudang = await GudangModel.fromFirestore(gudangDoc);
      }
    }

    return ProdukModel.fromFireStore(
      data,
      category!,
      type!,
      gudang!,
    );
  }
}
