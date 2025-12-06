import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/registrasi_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/widget/success_dialog.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  final Color _backgroundColor = Colors.lightGreen.shade50;
  final Color _primaryColor = Colors.lightGreen.shade700;
  final TextStyle _labelStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2D3748),
  );

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFFA0AEC0)),
      fillColor: const Color(0xFFF7FAFC),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.lightGreen.shade50, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Buat Akun Baru',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A202C),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Silakan lengkapi data diri Anda',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0XFF718096),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                      _namaTextField(),
                      const SizedBox(height: 24),

                      _emailTextField(),
                      const SizedBox(height: 24),

                      _passwordTextField(),
                      const SizedBox(height: 24),

                      _passwordKonfirmasiTextField(),
                      const SizedBox(height: 32),

                      _buttonRegistrasi(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama', style: _labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          controller: _namaTextboxController,
          keyboardType: TextInputType.text,
          decoration: _inputDecoration('Masukkan Nama Lengkap'),
          validator: (value) {
            if (value!.length < 3) {
              return "Nama harus diisi minimal 3 karakter";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _emailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: _labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailTextboxController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration('Masukkan Email'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email harus diisi';
            }
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern.toString());
            if (!regex.hasMatch(value)) {
              return "Email tidak valid";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _passwordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: _labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordTextboxController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: _inputDecoration('Masukkan Password'),
          validator: (value) {
            if (value!.length < 6) {
              return "Password harus diisi minimal 6 karakter";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Konfirmasi Password', style: _labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: _inputDecoration('Ulangi Password'),
          validator: (value) {
            if (value != _passwordTextboxController.text) {
              return "Konfirmasi Password tidak sama";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) _submit();
          }
        },
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Registrasi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then(
      (value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Registrasi berhasil, silahkan login",
            okClick: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Registrasi gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}
