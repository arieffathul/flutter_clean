import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getAllCategory();
  Future<Category> getCategoryById({required String id});
  // void tidak ada pengembalian
  Future<void> addCategory({required CategoryModels category});
  Future<void> editCategory({required CategoryModels category});
  Future<void> deleteCategory({required String id});
}

class CategoryRemoteDataSourceImplementation
    implements CategoryRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  CategoryRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addCategory({required CategoryModels category}) async {
    await firebaseFirestore
        .collection('categorys')
        .add(category.toFireStoreAdd());
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await firebaseFirestore.collection('categorys').doc(id).delete();
  }

  @override
  Future<void> editCategory({required CategoryModels category}) async {
    await firebaseFirestore
        .collection('categorys')
        .doc(category.id)
        .update(category.toFireStoreUpdate());
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final data = await firebaseFirestore.collection('categorys').get();
    return data.docs
        .map(
          (e) => CategoryModels.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Category> getCategoryById({required String id}) async {
    final data = await firebaseFirestore.collection('categorys').doc(id).get();
    return CategoryModels.fromFirestore(data);
  }
}
