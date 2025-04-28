import 'package:clean_flutter/features/category_product/data/models/category_models.dart';
import 'package:clean_flutter/features/category_product/domain/entities/category.dart';
import 'package:clean_flutter/features/category_product/presentation/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryPages extends StatelessWidget {
  const CategoryPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showCategoryFormModal(context, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: context.read<CategoryBloc>()..add(CategoryEventGetAll()),
        listener: (context, state) {
          if (state is CategoryStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is CategoryStateSuccess) {
            context.read<CategoryBloc>().add(CategoryEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is CategoryStateLoadedAll) {
            return ListView.builder(
              itemCount: state.categorys.length,
              itemBuilder: (context, index) {
                var category = state.categorys[index];
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
                            title: Text(category.namaCat),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category.deskripsi),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showCategoryFormModal(context, category);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context.read<CategoryBloc>().add(
                                        CategoryEventDelete(id: category.id));
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
          if (state is CategoryStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void showCategoryFormModal(BuildContext context, Category? category) {
    final isEdit = category != null;
    final namaCategoryController =
        TextEditingController(text: category?.namaCat ?? '');
    final deskripsiCategoryController =
        TextEditingController(text: category?.deskripsi ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? 'Edit Kategori' : 'Tambah Kategori'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: deskripsiCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, state) {
                      if (state is CategoryStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                      if (state is CategoryStateSuccess) {
                        context.pop();
                        context.read<CategoryBloc>().add(CategoryEventGetAll());
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isEdit == true) {
                            final model = CategoryModels(
                                id: category!.id,
                                namaCat: namaCategoryController.text,
                                deskripsi: deskripsiCategoryController.text,
                                updatedAt: DateTime.now());
                            context
                                .read<CategoryBloc>()
                                .add(CategoryEventEdit(categoryModel: model));
                          } else {
                            final model = CategoryModels(
                              id: '',
                              namaCat: namaCategoryController.text,
                              deskripsi: deskripsiCategoryController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<CategoryBloc>()
                                .add(CategoryEventAdd(categoryModel: model));
                          }
                        },
                        icon: state is CategoryStateLoading
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
