import 'package:clean_flutter/features/category_product/presentation/bloc/category_bloc.dart';
import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/product/data/models/product_model.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
import 'package:clean_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_flutter/features/type_product/presentation/bloc/type_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProdukPagesSample extends StatelessWidget {
  const ProdukPagesSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showProdukFormModal(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<ProdukBloc, ProdukState>(
        bloc: context.read<ProdukBloc>()..add(ProdukEventGetAll()),
        listener: (context, state) {
          if (state is ProdukStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ProdukStateSuccess) {
            context.read<ProdukBloc>().add(ProdukEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is ProdukStateLoadedAll) {
            return ListView.builder(
              itemCount: state.produks.length,
              itemBuilder: (context, index) {
                var produk = state.produks[index];
                return Container(
                  child: Column(
                    children: [
                      // widget product
                      ListTile(
                        title: Text(produk.namaProduk),
                        subtitle: Text(produk.harga),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showProdukFormModal(context, produk: produk);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<ProdukBloc>()
                                    .add(ProdukEventDelete(id: produk.id));
                              },
                            ),
                          ],
                        ),
                      ),
                      //widget category
                      BlocBuilder<CategoryBloc, CategoryState>(
                        bloc: context.read<CategoryBloc>()
                          ..add(CategoryEventGetById(
                              id: produk
                                  .categoryId!)), //get category berdasarkan produk -> categoryid
                        builder: (context, statecategory) {
                          if (statecategory is CategoryStateError) {
                            return Text(statecategory.message);
                          }
                          if (statecategory is CategoryStateLoaded) {
                            return Text(statecategory.category.namaCat);
                          }
                          return const SizedBox();
                        },
                      ),
                      // Widget Jenis
                      BlocBuilder<TypeBloc, TypeProductState>(
                        bloc: context.read<TypeBloc>()
                          ..add(TypeEventGetById(id: produk.typeId!)),
                        builder: (context, statetype) {
                          if (statetype is TypeProductStateError) {
                            return Text(statetype.message);
                          }
                          if (statetype is TypeProductStateLoaded) {
                            return Text(statetype.type.namatype);
                          }
                          return const SizedBox();
                        },
                      ),
                      // Widget Gudang
                      BlocBuilder<GudangBloc, GudangState>(
                        bloc: context.read<GudangBloc>()
                          ..add(GudangEventGetById(id: produk.gudangId!)),
                        builder: (context, stategudang) {
                          if (stategudang is GudangStateLoaded) {
                            return Text(stategudang.gudang.namaGudang);
                          }
                          if (stategudang is GudangStateError) {
                            return Text(stategudang.message);
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                );
              },
            );
          }
          if (state is ProdukStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Membuat variabel produk yang mengambil type dari entitas produk untuk menampung kiriman produk seperti di edit
  void showProdukFormModal(BuildContext context, {Produk? produk}) {
    // merekam isi data yang dikirim oleh edit berdasarkan struktur entitas Produk
    final isEdit = produk != null;
    final namaProdukController =
        TextEditingController(text: produk?.namaProduk ?? '');
    // final categoryIdController =
    //     TextEditingController(text: produk?.categoryId ?? '');
    // final typeIdController = TextEditingController(text: produk?.typeId ?? '');
    // final GudangIdController =
    //     TextEditingController(text: produk?.gudangId ?? '');
    final hargaProdukController =
        TextEditingController(text: produk?.harga ?? '');
    final deskripsiProdukController =
        TextEditingController(text: produk?.deskripsi ?? '');

    String? selectedCategoryId = produk?.categoryId;

    context.read<CategoryBloc>().add(CategoryEventGetAll());

    showModalBottomSheet(
      // Struktur UI Modal
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaProdukController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryStateError) {
                    return Text(state.message);
                  }
                  if (state is CategoryStateLoadedAll) {
                    final categories = state.categorys; // list<Category>

                    return DropdownButtonFormField<String>(
                      value: selectedCategoryId,
                      onChanged: (value) {
                        selectedCategoryId = value;
                      },
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.namaCat),
                        );
                      }).toList(),
                      decoration:
                          const InputDecoration(labelText: 'Kategori Produk'),
                    );
                  }

                  return const Text('Gagal memuat kategori');
                },
              ),
              TextFormField(
                controller: hargaProdukController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Harga Produk'),
              ),
              TextFormField(
                controller: deskripsiProdukController,
                decoration:
                    const InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              BlocConsumer<ProdukBloc, ProdukState>(
                listener: (context, state) {
                  if (state is ProdukStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                  if (state is ProdukStateSuccess) {
                    context.pop();
                    context.read<ProdukBloc>().add(ProdukEventGetAll());
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      final model = ProdukModel(
                        id: isEdit ? produk.id : '',
                        categoryId: selectedCategoryId,
                        namaProduk: namaProdukController.text,
                        harga: hargaProdukController.text,
                        deskripsi: deskripsiProdukController.text,
                      );

                      context.read<ProdukBloc>().add(
                            isEdit
                                ? ProdukEventEdit(produkModel: model)
                                : ProdukEventAdd(produkModel: model),
                          );
                    },
                    icon: state is ProdukStateLoading
                        ? const Text('Loading...')
                        : const Icon(Icons.save),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
