import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(80),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/8/88/President_Megawati_Sukarnoputri_-_Indonesia.jpg')),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ibrahim'),
                    Text('Email: ibra@gmail.com'),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Produk'),
            onTap: () {
              context.go('/produk');
            },
          ),
          ListTile(
            title: const Text('Kategori Produk'),
            onTap: () {
              context.go('/kategori');
            },
          ),
          ListTile(
            title: const Text('Jenis Produk'),
            onTap: () {
              context.go('/jenis');
            },
          ),
          ListTile(
            title: const Text('Gudang'),
            onTap: () {
              context.go('/gudang');
            },
          ),
        ],
      ),
    );
  }
}
