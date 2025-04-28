import 'package:clean_flutter/core/components/cubit/option/option_cubit.dart';
import 'package:clean_flutter/core/routes/routes.dart';
import 'package:clean_flutter/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_flutter/features/category_product/presentation/bloc/category_bloc.dart';
import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:clean_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_flutter/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:clean_flutter/features/type_product/presentation/bloc/type_product_bloc.dart';
import 'package:clean_flutter/firebase_options.dart';
import 'package:clean_flutter/my_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initializeDateFormatting('id_ID', null);
  // await Hive.initFlutter();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OptionCubit>(
          create: (context) => OptionCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            signInWithEmail: myinjection(),
            registerWithEmail: myinjection(), signOut: myinjection(),
            // signOut: myinjection(),
          ),
        ),
        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(
              produkUsecasesAdd: myinjection(),
              produkUsecasesDeleteProduk: myinjection(),
              produkUsecasesEditProduk: myinjection(),
              produkUsecasesGetAll: myinjection(),
              produkUsecasesGetById: myinjection()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
              categoryUsecasesAdd: myinjection(),
              categoryUsecasesEditCategory: myinjection(),
              categoryUsecasesDeleteCategory: myinjection(),
              categoryUsecasesGetAll: myinjection(),
              categoryUsecasesGetById: myinjection()),
        ),
        BlocProvider<TypeBloc>(
          create: (context) => TypeBloc(
              typeUsecasesAdd: myinjection(),
              typeUsecasesEditType: myinjection(),
              typeUsecasesDeleteType: myinjection(),
              typeUsecasesGetAll: myinjection(),
              typeUsecasesGetById: myinjection()),
        ),
        BlocProvider<GudangBloc>(
          create: (context) => GudangBloc(
              gudangUsecasesAdd: myinjection(),
              gudangUsecasesEditGudang: myinjection(),
              gudangUsecasesDeleteGudang: myinjection(),
              gudangUsecasesGetAll: myinjection(),
              gudangUsecasesGetById: myinjection()),
        ),
        BlocProvider<KurirBloc>(
          create: (context) => KurirBloc(
              kurirUsecasesAdd: myinjection(),
              kurirUsecasesEditKurir: myinjection(),
              kurirUsecasesDeleteKurir: myinjection(),
              kurirUsecasesGetAll: myinjection(),
              kurirUsecasesGetById: myinjection()),
        ),
        BlocProvider<SuplierBloc>(
          create: (context) => SuplierBloc(
              suplierUsecasesAdd: myinjection(),
              suplierUsecasesEditSuplier: myinjection(),
              suplierUsecasesDeleteSuplier: myinjection(),
              suplierUsecasesGetAll: myinjection(),
              suplierUsecasesGetById: myinjection()),
        ),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        color: Colors.white,
        // theme: AppThemes.light,
        // darkTheme: AppTheme.dark,
        routerConfig: MyRouter().router,
        // routerDelegate: AutoRouterDelegate(router),
        // routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
