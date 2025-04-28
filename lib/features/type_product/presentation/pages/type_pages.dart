import 'package:clean_flutter/core/components/custom_drawer.dart';
import 'package:clean_flutter/features/type_product/data/models/type_models.dart';
import 'package:clean_flutter/features/type_product/domain/entities/type_product.dart';
import 'package:clean_flutter/features/type_product/presentation/bloc/type_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TypePages extends StatelessWidget {
  const TypePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showTypeFormModal(context, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocConsumer<TypeBloc, TypeProductState>(
        bloc: context.read<TypeBloc>()..add(TypeEventGetAll()),
        listener: (context, state) {
          if (state is TypeProductStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is TypeProductStateSuccess) {
            context.read<TypeBloc>().add(TypeEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is TypeProductStateLoadedAll) {
            return ListView.builder(
              itemCount: state.types.length,
              itemBuilder: (context, index) {
                var type = state.types[index];
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
                            title: Text(type.namatype),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(type.deskripsi),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showTypeFormModal(context, type);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<TypeBloc>()
                                        .add(TypeEventDelete(id: type.id));
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
          if (state is TypeProductStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void showTypeFormModal(BuildContext context, TypeProduct? type) {
    final isEdit = type != null;
    final namaTypeController =
        TextEditingController(text: type?.namatype ?? '');
    final deskripsiTypeController =
        TextEditingController(text: type?.deskripsi ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? 'Edit Jenis' : 'Tambah Jenis'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: deskripsiTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  BlocConsumer<TypeBloc, TypeProductState>(
                    listener: (context, state) {
                      if (state is TypeProductStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                      if (state is TypeProductStateSuccess) {
                        context.pop();
                        context.read<TypeBloc>().add(TypeEventGetAll());
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isEdit == true) {
                            final model = TypeModels(
                                id: type!.id,
                                namatype: namaTypeController.text,
                                deskripsi: deskripsiTypeController.text,
                                updatedAt: DateTime.now());
                            context
                                .read<TypeBloc>()
                                .add(TypeEventEdit(typeModel: model));
                          } else {
                            final model = TypeModels(
                              id: '',
                              namatype: namaTypeController.text,
                              deskripsi: deskripsiTypeController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<TypeBloc>()
                                .add(TypeEventAdd(typeModel: model));
                          }
                        },
                        icon: state is TypeProductStateLoading
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
      },
    );
  }
}
