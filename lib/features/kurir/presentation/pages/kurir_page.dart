import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/kurir/data/models/kurir_model.dart';
import 'package:clean_flutter/features/kurir/domain/entities/kurir.dart';
import 'package:clean_flutter/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KurirPages extends StatelessWidget {
  const KurirPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kurir Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showKurirFormModal(context, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<KurirBloc, KurirState>(
        bloc: context.read<KurirBloc>()..add(KurirEventGetAll()),
        listener: (context, state) {
          if (state is KurirStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is KurirStateSuccess) {
            context.read<KurirBloc>().add(KurirEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is KurirStateLoadedAll) {
            return ListView.builder(
              itemCount: state.kurirs.length,
              itemBuilder: (context, index) {
                var kurir = state.kurirs[index];
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
                            title: Text(kurir.namaKurir),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kurir.noTelp),
                                Text(kurir.email),
                                Text(kurir.alamat),
                                Text(kurir.gudang?.namaGudang ?? ''),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showKurirFormModal(context, kurir);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<KurirBloc>()
                                        .add(KurirEventDelete(id: kurir.id));
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
          if (state is KurirStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void showKurirFormModal(BuildContext context, Kurir? kurir) {
    final isEdit = kurir != null;
    final namaKurirController =
        TextEditingController(text: kurir?.namaKurir ?? '');
    final noTelpKurirController =
        TextEditingController(text: kurir?.noTelp ?? '');
    final emailKurirController =
        TextEditingController(text: kurir?.email ?? '');
    final alamatKurirController =
        TextEditingController(text: kurir?.alamat ?? '');
    String? selectedValueGudangId =
        kurir?.gudangId != null && kurir!.gudangId!.isNotEmpty
            ? kurir.gudangId
            : null;
    showDialog(
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
                    controller: namaKurirController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Kurir',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: noTelpKurirController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'No. Telpon Kurir',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailKurirController,
                    decoration: const InputDecoration(
                      labelText: 'Email Kurir',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<GudangBloc, GudangState>(
                    bloc: context.read<GudangBloc>()..add(GudangEventGetAll()),
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
                  TextFormField(
                    controller: alamatKurirController,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Kurir',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  BlocConsumer<KurirBloc, KurirState>(
                    listener: (context, state) {
                      if (state is KurirStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                      if (state is KurirStateSuccess) {
                        context.pop();
                        context.read<KurirBloc>().add(KurirEventGetAll());
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isEdit == true) {
                            final model = KurirModel(
                              id: kurir!.id,
                              namaKurir: namaKurirController.text,
                              noTelp: noTelpKurirController.text,
                              email: emailKurirController.text,
                              alamat: alamatKurirController.text,
                              updatedAt: DateTime.now(),
                              gudangId: selectedValueGudangId,
                            );

                            context
                                .read<KurirBloc>()
                                .add(KurirEventEdit(kurirModel: model));
                          } else {
                            final model = KurirModel(
                              id: '',
                              namaKurir: namaKurirController.text,
                              noTelp: noTelpKurirController.text,
                              email: emailKurirController.text,
                              alamat: alamatKurirController.text,
                              gudangId: selectedValueGudangId,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<KurirBloc>()
                                .add(KurirEventAdd(kurirModel: model));
                          }
                        },
                        icon: state is KurirStateLoading
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
