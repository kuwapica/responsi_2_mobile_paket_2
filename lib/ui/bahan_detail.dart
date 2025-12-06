import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/bahan_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/bahan.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_form.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_page.dart';

class BahanDetail extends StatefulWidget {
  Bahan? bahan;

  BahanDetail({super.key, this.bahan});

  @override
  State<BahanDetail> createState() => _BahanDetailState();
}

class _BahanDetailState extends State<BahanDetail> {
  final Color _backgroundColor = Colors.lightGreen.shade50;
  final Color _primaryColor = Colors.lightGreen.shade700;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Detail Bahan Makanan Nida',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.bahan!.namaBahan}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    _buildDetailItem(
                      "Harga",
                      "Rp. ${widget.bahan!.hargaBahan.toString()}",
                    ),
                    _buildDetailItem(
                      "Jumlah",
                      "${widget.bahan!.jumlahBahan.toString()} buah",
                    ),
                    _buildDetailItem(
                      "Tanggal Masuk",
                      "${widget.bahan!.tanggalMasuk}",
                    ),
                    _buildDetailItem(
                      "Tanggal Kedaluwarsa",
                      "${widget.bahan!.tanggalKedaluwarsa}",
                    ),

                    const SizedBox(height: 32),

                    _tombolHapusEdit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.green,
            side: const BorderSide(color: Colors.green),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text("EDIT BAHAN NIDA"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BahanForm(bahan: widget.bahan!),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text("DELETE BAHAN NIDA"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            BahanBloc.deleteBahan(id: int.parse(widget.bahan!.id!)).then(
              (value) => {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BahanPage()),
                ),
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}

class WarningDialog extends StatelessWidget {
  final String description;

  const WarningDialog({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(description),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
