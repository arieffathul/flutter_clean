import 'package:clean_flutter/core/components/custom_drawer.dart';
import 'package:clean_flutter/features/gudang/data/models/gudang_model.dart';
import 'package:clean_flutter/features/gudang/domain/entities/gudang.dart';
import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GudangPages extends StatelessWidget {
  const GudangPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gudang Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showGudangFormModal(context, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocConsumer<GudangBloc, GudangState>(
        bloc: context.read<GudangBloc>()..add(GudangEventGetAll()),
        listener: (context, state) {
          if (state is GudangStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is GudangStateSuccess) {
            context.read<GudangBloc>().add(GudangEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is GudangStateLoadedAll) {
            return ListView.builder(
              itemCount: state.gudangs.length,
              itemBuilder: (context, index) {
                var gudang = state.gudangs[index];
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
                            title: Text(gudang.namaGudang),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(gudang.alamat),
                                Text(gudang.suplier?.namaSuplier ?? ''),
                                Text(gudang.kapasitas),
                                Text(gudang.deskripsi),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showGudangFormModal(context, gudang);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<GudangBloc>()
                                        .add(GudangEventDelete(id: gudang.id));
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
          if (state is GudangStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void showGudangFormModal(BuildContext context, Gudang? gudang) {
    final isEdit = gudang != null;
    final namaGudangController =
        TextEditingController(text: gudang?.namaGudang ?? '');
    final alamatGudangController =
        TextEditingController(text: gudang?.alamat ?? '');
    final kapasitasGudangController =
        TextEditingController(text: gudang?.kapasitas ?? '');
    final deskripsiGudangController =
        TextEditingController(text: gudang?.deskripsi ?? '');
    String? selectedValueSuplierId =
        gudang?.suplierId != null && gudang!.suplierId!.isNotEmpty
            ? gudang.suplierId
            : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? 'Edit Gudang' : 'Tambah Gudang'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaGudangController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Gudang',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<SuplierBloc, SuplierState>(
                    bloc: context.read<SuplierBloc>()
                      ..add(SuplierEventGetAll()),
                    builder: (context, state) {
                      if (state is SuplierStateError) {
                        return Text(state.message);
                      }
                      if (state is SuplierStateLoadedAll) {
                        final supliers = state.supliers;

                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          value: selectedValueSuplierId,
                          items: supliers
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.namaSuplier)),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedValueSuplierId = value;
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
                    controller: alamatGudangController,
                    decoration:
                        const InputDecoration(labelText: 'Alamat Gudang'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: kapasitasGudangController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration:
                        const InputDecoration(labelText: 'Kapasitas Gudang'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: deskripsiGudangController,
                    decoration:
                        const InputDecoration(labelText: 'Deskripsi Gudang'),
                  ),
                  BlocConsumer<GudangBloc, GudangState>(
                    listener: (context, state) {
                      if (state is GudangStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                      if (state is GudangStateSuccess) {
                        context.pop();
                        context.read<GudangBloc>().add(GudangEventGetAll());
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isEdit == true) {
                            final model = GudangModel(
                                id: gudang!.id,
                                namaGudang: namaGudangController.text,
                                alamat: alamatGudangController.text,
                                kapasitas: kapasitasGudangController.text,
                                deskripsi: deskripsiGudangController.text,
                                suplierId: selectedValueSuplierId,
                                updatedAt: DateTime.now());
                            context
                                .read<GudangBloc>()
                                .add(GudangEventEdit(gudangModel: model));
                          } else {
                            final model = GudangModel(
                              id: '',
                              namaGudang: namaGudangController.text,
                              alamat: alamatGudangController.text,
                              kapasitas: kapasitasGudangController.text,
                              deskripsi: deskripsiGudangController.text,
                              suplierId: selectedValueSuplierId,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            context
                                .read<GudangBloc>()
                                .add(GudangEventAdd(gudangModel: model));
                          }
                        },
                        icon: state is GudangStateLoading
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
