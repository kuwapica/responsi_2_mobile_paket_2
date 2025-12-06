import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/bahan_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/logout_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/bahan.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_detail.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_form.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/login_page.dart';

class BahanPage extends StatefulWidget {
  const BahanPage({super.key});

  @override
  _BahanPageState createState() => _BahanPageState();
}

class _BahanPageState extends State<BahanPage> {
  final Color _backgroundColor = Colors.lightGreen.shade50;
  final Color _primaryColor = Colors.lightGreen.shade700;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: const Text(
          'List Inventaris Bahan Makanan Nida',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then(
                  (value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    ),
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BahanBloc.getBahans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBahan(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _primaryColor, // Mengikuti warna tema hijau
        child: const Icon(Icons.add, size: 26.0, color: Colors.white),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BahanForm()),
          );
        },
      ),
    );
  }
}

class ListBahan extends StatelessWidget {
  final List? list;

  const ListBahan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemBahan(bahan: list![i]);
      },
    );
  }
}

class ItemBahan extends StatelessWidget {
  final Bahan bahan;

  const ItemBahan({Key? key, required this.bahan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BahanDetail(bahan: bahan)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(bahan.namaBahan!),
          subtitle: Text(bahan.hargaBahan.toString()),
        ),
      ),
    );
  }
}
