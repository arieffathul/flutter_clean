import 'package:clean_flutter/features/suplier/data/models/suplier_model.dart';
import 'package:clean_flutter/features/suplier/domain/entities/suplier.dart';
import 'package:clean_flutter/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SuplierPages extends StatelessWidget {
  const SuplierPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suplier Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showSuplierFormModal(context, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<SuplierBloc, SuplierState>(
        bloc: context.read<SuplierBloc>()..add(SuplierEventGetAll()),
        listener: (context, state) {
          if (state is SuplierStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is SuplierStateSuccess) {
            context.read<SuplierBloc>().add(SuplierEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is SuplierStateLoadedAll) {
            return ListView.builder(
              itemCount: state.supliers.length,
              itemBuilder: (context, index) {
                var suplier = state.supliers[index];
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
                            title: Text(suplier.namaSuplier),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(suplier.alamat),
                                Text(suplier.email),
                                Text(suplier.noTelp),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showSuplierFormModal(context, suplier);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context.read<SuplierBloc>().add(
                                        SuplierEventDelete(id: suplier.id));
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
          if (state is SuplierStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void showSuplierFormModal(BuildContext context, Suplier? suplier) {
    final isEdit = suplier != null;
    final namaSuplierController =
        TextEditingController(text: suplier?.namaSuplier ?? '');
    final alamatSuplierController =
        TextEditingController(text: suplier?.alamat ?? '');
    final noTelpSuplierController =
        TextEditingController(text: suplier?.noTelp ?? '');
    final emailSuplierController =
        TextEditingController(text: suplier?.email ?? '');

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
                    controller: namaSuplierController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Suplier',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: alamatSuplierController,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Suplier',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: noTelpSuplierController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'No. Telpon Suplier',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailSuplierController,
                    decoration: const InputDecoration(
                      labelText: 'Email Suplier',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  BlocConsumer<SuplierBloc, SuplierState>(
                    listener: (context, state) {
                      if (state is SuplierStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                      if (state is SuplierStateSuccess) {
                        context.pop();
                        context.read<SuplierBloc>().add(SuplierEventGetAll());
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isEdit == true) {
                            final model = SuplierModel(
                              id: suplier!.id,
                              namaSuplier: namaSuplierController.text,
                              alamat: alamatSuplierController.text,
                              noTelp: noTelpSuplierController.text,
                              email: emailSuplierController.text,
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<SuplierBloc>()
                                .add(SuplierEventEdit(suplierModel: model));
                          } else {
                            final model = SuplierModel(
                              id: '',
                              namaSuplier: namaSuplierController.text,
                              alamat: alamatSuplierController.text,
                              noTelp: noTelpSuplierController.text,
                              email: emailSuplierController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<SuplierBloc>()
                                .add(SuplierEventAdd(suplierModel: model));
                          }
                        },
                        icon: state is SuplierStateLoading
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
