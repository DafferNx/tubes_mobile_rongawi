import 'package:flutter/material.dart';

import '../../navigation/main_scaffold.dart';
import '../profile/edit_profile_page.dart';
import 'register_page.dart';

/// Halaman Login Pengguna (Bagian Orang 5)
/// Dilengkapi form email & password, dialog lupa password, dan login Google
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;

  bool get _isDark => UserProfileData.isDarkMode;
  String _tr(String id, String en, [String? su]) =>
      UserProfileData.tr(id, en, su);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _prosesLogin() {
    if (_formKey.currentState!.validate()) {
      final emailInput = _emailController.text.trim();
      UserProfileData.currentUser.email = emailInput;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _tr(
                    'Berhasil masuk sebagai $emailInput',
                    'Successfully signed in as $emailInput',
                    'Hasil lebet salaku $emailInput',
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

      _selesaiLogin();
    }
  }

  void _selesaiLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScaffold()),
      (route) => false,
    );
  }

  void _tampilkanDialogLupaPassword() {
    final resetEmailController = TextEditingController(
      text: _emailController.text.trim(),
    );
    final resetFormKey = GlobalKey<FormState>();
    final dialogBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isDark
                      ? Colors.orange.withValues(alpha: 0.15)
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lock_reset,
                  color: Colors.orange,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          content: Form(
            key: resetFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _tr(
                    'Masukkan alamat email yang terdaftar. Kami akan mengirimkan tautan untuk mengatur ulang password kamu.',
                    'Enter your registered email address. We will send a link to reset your password.',
                    'Lebetkeun alamat email anu kadaptar. Urang bakal ngirimkeun tautan reset password.',
                  ),
                  style: TextStyle(fontSize: 13, color: textColor),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: resetEmailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: 'contoh@email.com',
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
                        'Masukkan format email yang valid',
                        'Enter a valid email format',
                        'Lebetkeun format email anu leres',
                      );
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                _tr('Batal', 'Cancel', 'Batal'),
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (resetFormKey.currentState!.validate()) {
                  final targetEmail = resetEmailController.text.trim();
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.mark_email_read_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _tr(
                                'Tautan reset password telah dikirim ke $targetEmail',
                                'Password reset link has been sent to $targetEmail',
                                'Tautan reset password parantos dikirim ka $targetEmail',
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
                }
              },
              child: Text(
                _tr('Kirim Link Reset', 'Send Reset Link', 'Kirim Link Reset'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _loginDenganGoogle() {
    final akunGoogle = [
      {
        'name': 'Raka Pratama',
        'email': 'raka.foodies@gmail.com',
        'avatar': 'https://picsum.photos/id/64/300/300',
      },
      {
        'name': 'Nadia Putri',
        'email': 'nadia.kulinerbdg@gmail.com',
        'avatar': 'https://picsum.photos/id/65/300/300',
      },
    ];

    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardBg = _isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50;
    final borderColor = _isDark ? Colors.grey.shade700 : Colors.grey.shade200;
    final textColor = _isDark ? Colors.white : Colors.black87;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildGoogleBadge(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _tr(
                              'Pilih Akun Google',
                              'Choose a Google Account',
                              'Pilih Akun Google',
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _tr(
                              'untuk melanjutkan ke Bandung Foodies',
                              'to continue to Bandung Foodies',
                              'pikeun neraskeun ka Bandung Foodies',
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...akunGoogle.map((akun) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        final user = UserProfileData.currentUser;
                        user.fullName = akun['name']!;
                        user.email = akun['email']!;
                        user.avatarUrl = akun['avatar']!;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _tr(
                                      'Berhasil masuk dengan Google (${akun['email']})',
                                      'Signed in with Google (${akun['email']})',
                                      'Hasil lebet nganggo Google (${akun['email']})',
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

                        _selesaiLogin();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                akun['avatar']!,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return CircleAvatar(
                                    radius: 21,
                                    backgroundColor: Colors.orange.shade50,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.orange,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    akun['name']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    akun['email']!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final cardBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = _isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Banner Identitas Aplikasi (Seirama dengan HomePage)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.restaurant_menu,
                              color: Colors.orange,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bandung Foodies',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _tr(
                                    'Jelajahi seblak, bakso, mie ayam & cafe terbaik di Bandung!',
                                    'Explore the best seblak, bakso, noodles & cafes in Bandung!',
                                    'Kotéktak seblak, baso, mie ayam & cafe pangsaéna di Bandung!',
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. Judul Halaman Login
                    Text(
                      _tr(
                        'Selamat Datang Kembali!',
                        'Welcome Back!',
                        'Wilujeng Sumping Deui!',
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _tr(
                        'Silakan masuk menggunakan email dan password akunmu.',
                        'Please sign in using your account email and password.',
                        'Mangga lebet nganggo email sareng password akun anjeun.',
                      ),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 22),

                    // 4. Input Email
                    Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: textColor),
                      decoration: _buildInputDecoration(
                        hintText: _tr(
                          'Masukkan email (contoh: nama@email.com)',
                          'Enter email (e.g. name@email.com)',
                          'Lebetkeun email (conto: nami@email.com)',
                        ),
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return _tr(
                            'Email tidak boleh kosong',
                            'Email cannot be empty',
                            'Email teu kénging kosong',
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

                    // 5. Input Password
                    Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: TextStyle(color: textColor),
                      decoration: _buildInputDecoration(
                        hintText: _tr(
                          'Masukkan password (min. 6 karakter)',
                          'Enter password (min. 6 characters)',
                          'Lebetkeun password (min. 6 karakter)',
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
                            'Password minimal terdiri dari 6 karakter',
                            'Password must be at least 6 characters',
                            'Password minimal 6 karakter',
                          );
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // 6. Baris Ingat Saya & Lupa Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _rememberMe = val ?? false;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _tr('Ingat saya', 'Remember me', 'Inget abdi'),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _tampilkanDialogLupaPassword,
                          child: Text(
                            _tr(
                              'Lupa Password?',
                              'Forgot Password?',
                              'Hilap Password?',
                            ),
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 7. Tombol Masuk Utama
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
                        onPressed: _prosesLogin,
                        child: Text(
                          _tr('Masuk', 'Sign In', 'Lebet'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 8. Pembatas "atau masuk dengan"
                    Row(
                      children: [
                        Expanded(child: Divider(color: borderColor)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            _tr(
                              'atau masuk dengan',
                              'or sign in with',
                              'atanapi lebet nganggo',
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: borderColor)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 9. Tombol Masuk dengan Akun Google
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: cardBg,
                          foregroundColor: textColor,
                          side: BorderSide(color: borderColor),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _loginDenganGoogle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildGoogleBadge(),
                            const SizedBox(width: 10),
                            Text(
                              _tr(
                                'Masuk dengan Akun Google',
                                'Sign in with Google',
                                'Lebet nganggo Akun Google',
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 10. Navigasi ke Halaman Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _tr(
                            'Belum punya akun? ',
                            'Don\'t have an account? ',
                            'Teu acan gaduh akun? ',
                          ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            _tr(
                              'Daftar Sekarang',
                              'Register Now',
                              'Daptar Ayeuna',
                            ),
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
        ),
      ),
    );
  }

  Widget _buildGoogleBadge() {
    return const SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final fillColor = _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor = _isDark ? Colors.grey.shade700 : Colors.grey.shade300;

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

/// Menggambar logo 'G' resmi 4 warna Google (Biru, Merah, Kuning, Hijau) secara vektor
class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.21;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // 1. Bagian Biru (Kanan Bawah)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -0.12, 1.08, false, paint);

    // 2. Bagian Hijau (Bawah)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.96, 1.56, false, paint);

    // 3. Bagian Kuning (Kiri)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, 2.52, 1.24, false, paint);

    // 4. Bagian Merah (Atas)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, 3.76, 1.72, false, paint);

    // 5. Garis Horizontal Biru di Tengah Kanan
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx - strokeWidth * 0.1,
        center.dy - strokeWidth * 0.48,
        radius + strokeWidth * 0.58,
        strokeWidth * 0.96,
      ),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
