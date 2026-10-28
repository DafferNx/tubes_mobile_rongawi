import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../profile/edit_profile_page.dart';

/// Halaman Register Pengguna Baru (Bagian Orang 5)
/// Dilengkapi form identitas, email, password, dan konfirmasi password dengan validasi visual
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedLocation = 'Dago';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _showTermsError = false;

  bool get _isDark => UserProfileData.isDarkMode;
  String _tr(String id, String en, [String? su]) =>
      UserProfileData.tr(id, en, su);

  List<String> get _pilihanLokasi =>
      lokasiBandung.where((lok) => lok != 'Semua Lokasi').toList();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _prosesRegister() {
    final formValid = _formKey.currentState!.validate();
    if (!_agreeTerms) {
      setState(() {
        _showTermsError = true;
      });
    }

    if (formValid && _agreeTerms) {
      final user = UserProfileData.currentUser;
      user.fullName = _nameController.text.trim();
      user.email = _emailController.text.trim();
      user.phone = _phoneController.text.trim();
      user.location = _selectedLocation;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _tr(
                    'Pendaftaran berhasil! Selamat datang, ${user.fullName}.',
                    'Registration successful! Welcome, ${user.fullName}.',
                    'Pendaptaran hasil! Wilujeng sumping, ${user.fullName}.',
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final fieldBg = _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor =
        _isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: fieldBg,
              child: Icon(Icons.chevron_left, color: textColor),
            ),
          ),
        ),
        title: Text(
          _tr('Daftar Akun Baru', 'Create New Account', 'Daptar Akun Anyar'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Info Singkat Pendaftaran
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _isDark
                        ? Colors.orange.withValues(alpha: 0.15)
                        : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _tr(
                            'Lengkapi identitasmu untuk mulai menjelajahi kuliner favorit di Bandung.',
                            'Complete your details to start exploring your favorite culinary spots in Bandung.',
                            'Lengkepan idéntitas anjeun pikeun ngamimitian ngotéktak kuliner karesep di Bandung.',
                          ),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Nama Lengkap
                _buildFieldLabel(
                  _tr('Nama Lengkap', 'Full Name', 'Nami Lengkep'),
                  textColor,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: _tr(
                      'Masukkan nama lengkap kamu',
                      'Enter your full name',
                      'Lebetkeun nami lengkep anjeun',
                    ),
                    icon: Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return _tr(
                        'Nama lengkap wajib diisi',
                        'Full name is required',
                        'Nami lengkep wajib dieusi',
                      );
                    }
                    if (value.trim().length < 3) {
                      return _tr(
                        'Nama minimal 3 karakter',
                        'Name must be at least 3 characters',
                        'Nami minimal 3 karakter',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3. Email
                _buildFieldLabel('Email', textColor),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: _tr(
                      'Masukkan alamat email aktif',
                      'Enter an active email address',
                      'Lebetkeun alamat email aktip',
                    ),
                    icon: Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return _tr(
                        'Email wajib diisi',
                        'Email is required',
                        'Email wajib dieusi',
                      );
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return _tr(
                        'Masukkan format email yang valid (mengandung @)',
                        'Enter a valid email format (containing @)',
                        'Lebetkeun format email anu leres',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 4. Nomor Telepon
                _buildFieldLabel(
                  _tr('Nomor Telepon', 'Phone Number', 'Nomor Telepon'),
                  textColor,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: 'Contoh: 081234567890',
                    icon: Icons.phone_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return _tr(
                        'Nomor telepon wajib diisi',
                        'Phone number is required',
                        'Nomor telepon wajib dieusi',
                      );
                    }
                    if (value.trim().length < 10) {
                      return _tr(
                        'Nomor telepon minimal 10 digit',
                        'Phone number must be at least 10 digits',
                        'Nomor telepon minimal 10 digit',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 5. Lokasi Kawasan di Bandung
                _buildFieldLabel(
                  _tr(
                    'Kawasan Domisili di Bandung',
                    'Area in Bandung',
                    'Wewengkon di Bandung',
                  ),
                  textColor,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          value: _selectedLocation,
                          dropdownColor: fieldBg,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: _pilihanLokasi.map((lokasi) {
                            return DropdownMenuItem<String>(
                              value: lokasi,
                              child: Text(
                                '$lokasi, Bandung',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 6. Password
                _buildFieldLabel('Password', textColor),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: TextStyle(color: textColor),
                  onChanged: (_) {
                    if (_confirmPasswordController.text.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  decoration: _buildInputDecoration(
                    hintText: _tr(
                      'Minimal 6 karakter',
                      'Minimum 6 characters',
                      'Minimal 6 karakter',
                    ),
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _tr(
                        'Password tidak boleh kosong',
                        'Password cannot be empty',
                        'Password teu kénging kosong',
                      );
                    }
                    if (value.length < 6) {
                      return _tr(
                        'Password minimal 6 karakter',
                        'Password must be at least 6 characters',
                        'Password minimal 6 karakter',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 7. Konfirmasi Password
                _buildFieldLabel(
                  _tr(
                    'Konfirmasi Password',
                    'Confirm Password',
                    'Konfirmasi Password',
                  ),
                  textColor,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: _tr(
                      'Ulangi password yang sama',
                      'Repeat the same password',
                      'Ulangi password anu sami',
                    ),
                    icon: Icons.verified_user_outlined,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _tr(
                        'Konfirmasi password wajib diisi',
                        'Password confirmation is required',
                        'Konfirmasi password wajib dieusi',
                      );
                    }
                    if (value != _passwordController.text) {
                      return _tr(
                        'Konfirmasi password tidak cocok dengan password',
                        'Password confirmation does not match',
                        'Konfirmasi password teu cocok',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // 8. Persetujuan Syarat & Ketentuan
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _agreeTerms = !_agreeTerms;
                      if (_agreeTerms) _showTermsError = false;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: _agreeTerms,
                          activeColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                              if (_agreeTerms) _showTermsError = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _tr(
                            'Saya menyetujui ketentuan pengguna Bandung Foodies.',
                            'I agree to Bandung Foodies terms of service.',
                            'Abdi satuju kana katangtosan pamaké Bandung Foodies.',
                          ),
                          style: TextStyle(fontSize: 12, color: textColor),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showTermsError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      _tr(
                        'Harap centang persetujuan ketentuan terlebih dahulu',
                        'Please agree to the terms of service first',
                        'Mangga centang pasatujuan katangtosan heula',
                      ),
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 24),

                // 9. Tombol Daftar Akun
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _prosesRegister,
                    child: Text(
                      _tr('Daftar Akun', 'Create Account', 'Daptar Akun'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 10. Tautan Kembali ke Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _tr(
                        'Sudah punya akun? ',
                        'Already have an account? ',
                        'Parantos gaduh akun? ',
                      ),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        _tr('Masuk di sini', 'Sign in here', 'Lebet di dieu'),
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, Color textColor) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: textColor,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final fillColor = _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor =
        _isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.orange, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }
}
