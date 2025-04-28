import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TypeRemoteDataSource {
  Future<List<TypeModels>> getAllType();
  Future<TypeModels> getTypeById({required String id});
  // void tidak ada pengembalian
  Future<void> addType({required TypeModels type});
  Future<void> editType({required TypeModels type});
  Future<void> deleteType({required String id});
}

class TypeRemoteDataSourceImplementation implements TypeRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  TypeRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addType({required TypeModels type}) async {
    await firebaseFirestore.collection('types').add(type.toFireStoreAdd());
  }

  @override
  Future<void> deleteType({required String id}) async {
    await firebaseFirestore.collection('types').doc(id).delete();
  }

  @override
  Future<void> editType({required TypeModels type}) async {
    await firebaseFirestore
        .collection('types')
        .doc(type.id)
        .update(type.toFireStoreUpdate());
  }

  @override
  Future<List<TypeModels>> getAllType() async {
    final data = await firebaseFirestore.collection('types').get();
    return data.docs
        .map(
          (e) => TypeModels.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<TypeModels> getTypeById({required String id}) async {
    final data = await firebaseFirestore.collection('types').doc(id).get();
    return TypeModels.fromFirestore(data);
  }
}
