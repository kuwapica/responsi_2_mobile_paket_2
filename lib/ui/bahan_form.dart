import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/bahan_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/bahan.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_page.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/widget/warning_dialog.dart';

class BahanForm extends StatefulWidget {
  Bahan? bahan;
  BahanForm({super.key, this.bahan});

  @override
  State<BahanForm> createState() => _BahanFormState();
}

class _BahanFormState extends State<BahanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH BAHAN NIDA";
  String tombolSubmit = "SIMPAN";
  final _namaBahanTextboxController = TextEditingController();
  final _hargaBahanTextboxController = TextEditingController();
  final _jumlahBahanTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _tanggalKedaluwarsaTextboxController = TextEditingController();
  final Color _backgroundColor = Colors.lightGreen.shade50;
  final Color _primaryColor = Colors.lightGreen.shade700;

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.bahan != null) {
      setState(() {
        judul = "UBAH BAHAN NIDA";
        tombolSubmit = "UBAH BAHAN NIDA";
        _namaBahanTextboxController.text = widget.bahan!.namaBahan!;
        _hargaBahanTextboxController.text = widget.bahan!.hargaBahan.toString();
        _jumlahBahanTextboxController.text = widget.bahan!.jumlahBahan
            .toString();
        _tanggalMasukTextboxController.text = widget.bahan!.tanggalMasuk!;
        _tanggalKedaluwarsaTextboxController.text =
            widget.bahan!.tanggalKedaluwarsa!;
      });
    } else {
      judul = "TAMBAH BAHAN MAKANAN NIDA";
      tombolSubmit = "SIMPAN BAHAN NIDA";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          judul,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaBahanTextField(),
                _hargaBahanTextField(),
                _jumlahBahanTextField(),
                _tanggalMasukTextField(),
                _tanggalKedaluwarsaTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaBahanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Bahan"),
      keyboardType: TextInputType.text,
      controller: _namaBahanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Bahan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaBahanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaBahanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahBahanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _jumlahBahanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Masuk"),
      keyboardType: TextInputType.text,
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal masuk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalKedaluwarsaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Kedaluwarsa"),
      keyboardType: TextInputType.text,
      controller: _tanggalKedaluwarsaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal kedaluwarsa harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor, // Warna Teks
        side: BorderSide(color: _primaryColor), // Warna Border
      ),
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();

        if (validate) {
          if (!_isLoading) {
            if (widget.bahan != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Bahan createBahan = Bahan(id: null);
    createBahan.namaBahan = _namaBahanTextboxController.text;
    createBahan.hargaBahan = int.parse(_hargaBahanTextboxController.text);
    createBahan.jumlahBahan = int.parse(_jumlahBahanTextboxController.text);
    createBahan.tanggalMasuk = _tanggalMasukTextboxController.text;
    createBahan.tanggalKedaluwarsa = _tanggalKedaluwarsaTextboxController.text;
    BahanBloc.addBahan(bahan: createBahan).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const BahanPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Bahan updateBahan = Bahan(id: widget.bahan!.id!);
    updateBahan.namaBahan = _namaBahanTextboxController.text;
    updateBahan.hargaBahan = int.parse(_hargaBahanTextboxController.text);
    updateBahan.jumlahBahan = int.parse(_jumlahBahanTextboxController.text);
    updateBahan.tanggalMasuk = _tanggalMasukTextboxController.text;
    updateBahan.tanggalKedaluwarsa = _tanggalKedaluwarsaTextboxController.text;
    BahanBloc.updateBahan(bahan: updateBahan).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const BahanPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}
