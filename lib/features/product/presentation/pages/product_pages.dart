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

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showProdukFormModal(context, null);
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(produk.namaProduk),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(produk.harga),
                                Text(produk.deskripsi),
                                Text(produk.category?.namaCat ?? ''),
                                Text(produk.type?.namatype ?? ''),
                                Text(produk.gudang?.namaGudang ?? ''),

                                // Text(produk.gudangId != null &&
                                //         produk.gudangId!.isNotEmpty
                                //     ? produk.gudang!.namaGudang
                                //     : ''),
                                // //widget category
                                // produk.categoryId != null &&
                                //         produk.categoryId!.isNotEmpty
                                //     ? BlocBuilder<CategoryBloc, CategoryState>(
                                //         bloc: context.read<CategoryBloc>()
                                //           ..add(CategoryEventGetById(
                                //               id: produk.categoryId ??
                                //                   '')), //get category berdasarkan produk -> categoryid
                                //         builder: (context, statecategory) {
                                //           if (statecategory
                                //               is CategoryStateError) {
                                //             return Text(statecategory.message);
                                //           }
                                //           if (statecategory
                                //               is CategoryStateLoaded) {
                                //             return Text(
                                //                 statecategory.category.namaCat);
                                //           }
                                //           return const SizedBox();
                                //         },
                                //       )
                                //     : const SizedBox(),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showProdukFormModal(context, produk);
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
                        ],
                      ),
                    ),
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
  void showProdukFormModal(BuildContext context, Produk? produk) {
    // merekam isi data yang dikirim oleh edit berdasarkan struktur entitas Produk
    final isEdit = produk != null;
    // TextEditingController untuk mengisi form text
    final namaProdukController =
        TextEditingController(text: produk?.namaProduk);
    final hargaProdukController = TextEditingController(text: produk?.harga);
    final deskripsiProdukController =
        TextEditingController(text: produk?.deskripsi);
    String? selectedValueCategoryId =
        produk?.categoryId != null && produk!.categoryId!.isNotEmpty
            ? produk.categoryId
            : null;
    // String? selectedValueTypeId = produk?.typeId;
    String? selectedValueTypeId =
        produk?.typeId != null && produk!.typeId!.isNotEmpty
            ? produk.typeId
            : null;
    String? selectedValueGudangId =
        produk?.gudangId != null && produk!.gudangId!.isNotEmpty
            ? produk.gudangId
            : null;

    showDialog(
      // Struktur UI Modal
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaProdukController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Produk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    bloc: context.read<CategoryBloc>()
                      ..add(CategoryEventGetAll()),
                    builder: (context, state) {
                      if (state is CategoryStateError) {
                        return Text(state.message);
                      }
                      if (state is CategoryStateLoadedAll) {
                        final categories = state.categorys;

                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          value: selectedValueCategoryId,
                          items: categories
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.namaCat)),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedValueCategoryId = value;
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<TypeBloc, TypeProductState>(
                    bloc: context.read<TypeBloc>()
                      ..add(
                        TypeEventGetAll(),
                      ),
                    builder: (context, state) {
                      if (state is TypeProductStateError) {
                        return Text(state.message);
                      }
                      if (state is TypeProductStateLoadedAll) {
                        final types = state.types;

                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          value: selectedValueTypeId,
                          items: types
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.namatype)),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedValueTypeId = value;
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<GudangBloc, GudangState>(
                    bloc: context.read<GudangBloc>()
                      ..add(
                        GudangEventGetAll(),
                      ),
                    builder: (context, state) {
                      if (state is GudangStateError) {
                        return Text(state.message);
                      }
                      if (state is GudangStateLoadedAll) {
                        final gudangs = state.gudangs;

                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          value: selectedValueGudangId,
                          items: gudangs
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.namaGudang)),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedValueGudangId = value;
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: hargaProdukController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Harga Produk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: deskripsiProdukController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Produk',
                      border: OutlineInputBorder(),
                    ),
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
                          if (isEdit == true) {
                            final model = ProdukModel(
                                id: produk!.id,
                                namaProduk: namaProdukController.text,
                                categoryId: selectedValueCategoryId,
                                typeId: selectedValueTypeId,
                                gudangId: selectedValueGudangId,
                                harga: hargaProdukController.text,
                                deskripsi: deskripsiProdukController.text,
                                updatedAt: DateTime.now());
                            context
                                .read<ProdukBloc>()
                                .add(ProdukEventEdit(produkModel: model));
                          } else {
                            final model = ProdukModel(
                                id: '',
                                namaProduk: namaProdukController.text,
                                categoryId: selectedValueCategoryId,
                                typeId: selectedValueTypeId,
                                gudangId: selectedValueGudangId,
                                harga: hargaProdukController.text,
                                deskripsi: deskripsiProdukController.text,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now());
                            context
                                .read<ProdukBloc>()
                                .add(ProdukEventAdd(produkModel: model));
                          }
                        },
                        icon: state is ProdukStateLoading
                            ? const Text('Loading...')
                            : const Icon(Icons.save),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
        // return Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
      },
    );
  }
}
