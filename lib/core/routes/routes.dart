import 'package:clean_flutter/features/Auth/presentation/pages/login_pages.dart';
import 'package:clean_flutter/features/Auth/presentation/pages/register_pages.dart';
import 'package:clean_flutter/features/category_product/presentation/pages/category_pages.dart';
import 'package:clean_flutter/features/gudang/presentation/pages/gudang_page.dart';
import 'package:clean_flutter/features/kurir/presentation/pages/kurir_page.dart';
import 'package:clean_flutter/features/product/presentation/pages/product_pages%20copy.dart';
import 'package:clean_flutter/features/product/presentation/pages/product_pages.dart';
import 'package:clean_flutter/features/suplier/presentation/pages/suplier_pages.dart';
import 'package:clean_flutter/features/type_product/presentation/pages/type_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AuthNotifier extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
}

class MyRouter {
  get router => GoRouter(
        initialLocation: '/',
        // redirect: (context, state) {},
        routes: [
          GoRoute(
            path: '/',
            name: 'login',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginPage()),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RegisterPages()),
          ),
          GoRoute(
            path: '/produk',
            name: 'produk',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProdukPages()),
          ),
          GoRoute(
            path: '/sample',
            name: 'sample',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProdukPagesSample()),
          ),
          GoRoute(
            path: '/category',
            name: 'category',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CategoryPages()),
          ),
          GoRoute(
            path: '/type',
            name: 'type',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TypePages()),
          ),
          GoRoute(
            path: '/gudang',
            name: 'gudang',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: GudangPages()),
          ),
          GoRoute(
            path: '/kurir',
            name: 'kurir',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: KurirPages()),
          ),
          GoRoute(
            path: '/suplier',
            name: 'suplier',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SuplierPages()),
          ),
        ],
      );
}
