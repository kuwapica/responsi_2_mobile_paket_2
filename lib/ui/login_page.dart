import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/bloc/login_bloc.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/user_info.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_page.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/registrasi_page.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/widget/success_dialog.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A202C),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Silakan masuk dengan akun Anda',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0XFF718096),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),

                      _emailTextField(),
                      const SizedBox(height: 24),

                      _passwordTextField(),
                      const SizedBox(height: 32),

                      _buttonLogin(),
                      const SizedBox(height: 24),

                      const Center(
                        child: Text(
                          "Atau",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _menuRegistrasi(),
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

  Widget _emailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: _labelStyle),
        const SizedBox(height: 8),
        TextFormField(
          decoration: _inputDecoration("Masukkan Email"),
          keyboardType: TextInputType.emailAddress,
          controller: _emailTextboxController,
          validator: (value) {
            //validasi harus diisi
            if (value!.isEmpty) {
              return 'Email harus diisi';
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
          decoration: _inputDecoration("Masukkan Password"),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: _passwordTextboxController,
          validator: (value) {
            //jika karakter yang dimasukkan kurang dari 6 karakter
            if (value!.isEmpty) {
              return "Password harus diisi";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buttonLogin() {
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
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();

          if (validate) {
            if (!_isLoading) _submit();
          }
        },
      ),
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
        child: RichText(
          text: TextSpan(
            text: "Belum punya akun? ",
            style: const TextStyle(color: Color(0XFF718096), fontSize: 16),
            children: [
              TextSpan(
                text: "Registrasi",
                style: TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
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
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then(
      (value) async {
        if (value.code == 200) {
          await UserInfo().setToken(value.token.toString());
          await UserInfo().setUserID(int.parse(value.userID.toString()));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => SuccessDialog(
              description: "Login berhasil, selamat datang!",
              okClick: () {
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const BahanPage()),
                  (route) => false,
                );
              },
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
              description: "Login gagal, silahkan coba lagi",
            ),
          );
        }
      },
      onError: (error) {
        print(error);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      },
    );
  }
}
