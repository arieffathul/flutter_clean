// Auth
import 'package:clean_flutter/core/components/cubit/option/option_cubit.dart';
import 'package:clean_flutter/features/Auth/data/datasources/auth_datasource.dart';
import 'package:clean_flutter/features/Auth/data/repositories/auth_repositories_implementation.dart';
import 'package:clean_flutter/features/Auth/domain/repositories/users_repositories.dart';
import 'package:clean_flutter/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:clean_flutter/features/Auth/presentation/bloc/auth_bloc.dart';

// Category
import 'package:clean_flutter/features/category_product/data/datasources/category_datasources.dart';
import 'package:clean_flutter/features/category_product/data/repositories/category_repository_imp.dart';
import 'package:clean_flutter/features/category_product/domain/repositories/category_repositories.dart';
import 'package:clean_flutter/features/category_product/domain/usecases/category_usecase.dart';
import 'package:clean_flutter/features/category_product/presentation/bloc/category_bloc.dart';
// GUDANG
import 'package:clean_flutter/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:clean_flutter/features/gudang/data/repositories/gudang_repository_impl.dart';
import 'package:clean_flutter/features/gudang/domain/repositories/gudang_repository.dart';
import 'package:clean_flutter/features/gudang/domain/usecases/gudang_usecase.dart';
import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/keranjang/data/datasources/keranjang_datasource.dart';
import 'package:clean_flutter/features/keranjang/data/repositories/keranjang_repo_impl.dart';
import 'package:clean_flutter/features/keranjang/domain/repositories/keranjang_repo.dart';
import 'package:clean_flutter/features/keranjang/domain/usecases/keranjang_usecase.dart';
import 'package:clean_flutter/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:clean_flutter/features/kurir/data/datasources/kurir_datasource.dart';
import 'package:clean_flutter/features/kurir/data/repositories/kurir_repository_impl.dart';
import 'package:clean_flutter/features/kurir/domain/repositories/kurir_repository.dart';
import 'package:clean_flutter/features/kurir/domain/usecases/kurir_usecase.dart';
import 'package:clean_flutter/features/kurir/presentation/bloc/kurir_bloc.dart';

// Product
import 'package:clean_flutter/features/product/data/datasources/product_datasource.dart';
import 'package:clean_flutter/features/product/data/repositories/product_repository_impl.dart';
import 'package:clean_flutter/features/product/domain/repositories/produk_repositories.dart';
import 'package:clean_flutter/features/product/domain/usecases/product_usecases.dart';
import 'package:clean_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_flutter/features/suplier/data/datasources/suplier_datasource.dart';
import 'package:clean_flutter/features/suplier/data/repositories/suplier_repository_impl.dart';
import 'package:clean_flutter/features/suplier/domain/repositories/suplier_repository.dart';
import 'package:clean_flutter/features/suplier/domain/usecases/suplier_usecase.dart';
import 'package:clean_flutter/features/suplier/presentation/bloc/suplier_bloc.dart';

// Type
import 'package:clean_flutter/features/type_product/data/datasources/type_datasources.dart';
import 'package:clean_flutter/features/type_product/data/repositories/type_repository_imp.dart';
import 'package:clean_flutter/features/type_product/domain/repositories/type_repository.dart';
import 'package:clean_flutter/features/type_product/domain/usecases/type_usecase.dart';
import 'package:clean_flutter/features/type_product/presentation/bloc/type_product_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

var myinjection = GetIt.instance;
Future<void> init() async {
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);
  var box = await Hive.openBox('box');
  myinjection.registerLazySingleton(() => box);
  // myinjection.registerLazySingleton(() => FirebaseStorage.instance);

  // option
  myinjection.registerFactory(
    () => OptionCubit(),
  );

  /// FEATURE - AUTH
  // BLOC
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(),
      registerWithEmail: myinjection(), signOut: myinjection(),
      // signOut: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SignInWithEmail(repository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SignOut(repository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => RegisterWithEmail(repository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImplementation(dataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(
            firebaseAuth: myinjection<FirebaseAuth>(),
            firebaseFirestore: myinjection<FirebaseFirestore>(),
            box: myinjection(),
          ));

  /// FEATURE - PRODUK
  // BLOC
  myinjection.registerFactory(
    () => ProdukBloc(
        produkUsecasesAdd: myinjection(),
        produkUsecasesDeleteProduk: myinjection(),
        produkUsecasesEditProduk: myinjection(),
        produkUsecasesGetAll: myinjection(),
        produkUsecasesGetById: myinjection()),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => ProdukUsecasesAddProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesDeleteProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesEditProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetAll(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetById(produkRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<ProdukRepositories>(
    () => ProdukRepoImpl(produkRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<ProdukRemoteDataSource>(() =>
      ProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

  // FEATURE - CATEGORY
  // BLOC
  myinjection.registerFactory(
    () => CategoryBloc(
      categoryUsecasesAdd: myinjection(),
      categoryUsecasesEditCategory: myinjection(),
      categoryUsecasesDeleteCategory: myinjection(),
      categoryUsecasesGetAll: myinjection(),
      categoryUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => CategoryUsecasesAddCategory(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesDeleteCategory(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesEditCategory(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecaseGetAll(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesGetById(categoryRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<CategoryRepositories>(
    () => CategoryRepoImpl(categoryRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImplementation(
        firebaseFirestore: myinjection()),
  );

  // FEATURE - TYPE
  // BLOC
  myinjection.registerFactory(
    () => TypeBloc(
      typeUsecasesAdd: myinjection(),
      typeUsecasesEditType: myinjection(),
      typeUsecasesDeleteType: myinjection(),
      typeUsecasesGetAll: myinjection(),
      typeUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => TypeUsecasesAddType(typeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => TypeUsecasesDeleteType(typeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => TypeUsecasesEditType(typeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => TypeUsecaseGetAll(typeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => TypeUsecasesGetById(typeRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<TypeRepository>(
    () => TypeRepoImpl(typeRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<TypeRemoteDataSource>(
    () => TypeRemoteDataSourceImplementation(firebaseFirestore: myinjection()),
  );

  // FEATURE - GUDANG
  // BLOC
  myinjection.registerFactory(
    () => GudangBloc(
      gudangUsecasesAdd: myinjection(),
      gudangUsecasesEditGudang: myinjection(),
      gudangUsecasesDeleteGudang: myinjection(),
      gudangUsecasesGetAll: myinjection(),
      gudangUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => GudangUsecasesAddGudang(gudangRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesDeleteGudang(gudangRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesEditGudang(gudangRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecaseGetAll(gudangRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesGetById(gudangRepository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<GudangRepository>(
    () => GudangRepoImpl(gudangRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<GudangRemoteDataSource>(
    () =>
        GudangRemoteDataSourceImplementation(firebaseFirestore: myinjection()),
  );

  // FEATURE - KURIR
  // BLOC
  myinjection.registerFactory(
    () => KurirBloc(
      kurirUsecasesAdd: myinjection(),
      kurirUsecasesEditKurir: myinjection(),
      kurirUsecasesDeleteKurir: myinjection(),
      kurirUsecasesGetAll: myinjection(),
      kurirUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => KurirUsecasesAddKurir(kurirRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesDeleteKurir(kurirRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesEditKurir(kurirRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecaseGetAll(kurirRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesGetById(kurirRepository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<KurirRepository>(
    () => KurirRepoImpl(kurirRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KurirRemoteDataSource>(
    () => KurirRemoteDataSourceImplementation(firebaseFirestore: myinjection()),
  );

  // FEATURE - SUPLIER
  // BLOC
  myinjection.registerFactory(
    () => SuplierBloc(
      suplierUsecasesAdd: myinjection(),
      suplierUsecasesEditSuplier: myinjection(),
      suplierUsecasesDeleteSuplier: myinjection(),
      suplierUsecasesGetAll: myinjection(),
      suplierUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SuplierUsecasesAddSuplier(suplierRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesDeleteSuplier(suplierRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesEditSuplier(suplierRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecaseGetAll(suplierRepository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesGetById(suplierRepository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<SuplierRepository>(
    () => SuplierRepoImpl(suplierRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<SuplierRemoteDataSource>(
    () =>
        SuplierRemoteDataSourceImplementation(firebaseFirestore: myinjection()),
  );

  /// FEATURE - Keranjang
  // BLOC
  myinjection.registerFactory(
    () => KeranjangBloc(
      keranjangUsecasesAdd: myinjection(),
      keranjangUsecasesEditKeranjang: myinjection(),
      keranjangUsecasesDeleteKeranjang: myinjection(),
      keranjangUsecasesGetAll: myinjection(),
      keranjangUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesAddKeranjang(keranjangRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesEditKeranjang(keranjangRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () =>
        KeranjangUsecasesDeleteKeranjang(keranjangRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesGetAll(keranjangRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesGetById(keranjangRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<KeranjangRepo>(
    () => KeranjangRepoImpl(keranjangRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KeranjangRemoteDataSource>(() =>
      KeranjangRemoteDataSourceImplementation(
          firebaseFirestore: myinjection()));
}
