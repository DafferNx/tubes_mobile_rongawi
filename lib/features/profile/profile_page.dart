import 'package:flutter/material.dart';

import '../auth/login_page.dart';
import '../favorites/favorites_page.dart';
import '../reviews/reviews_page.dart';
import '../search/search_page.dart';
import 'edit_profile_page.dart';

/// Halaman Profile Pengguna (Bagian Orang 5)
/// Terhubung pada tab Profile di BottomNavigationBar (MainScaffold)
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notifPromo = true;
  bool _autoLocation = true;
  String _cacheSize = '24.8 MB';

  bool get _isDark => UserProfileData.currentUser.isDark;
  String get _lang => UserProfileData.currentUser.language;

  String _tr(String id, String en, [String? su]) {
    if (_lang == 'English') return en;
    if (_lang == 'Sunda') return su ?? id;
    return id;
  }

  Future<void> _bukaEditProfil() async {
    final diperbarui = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );

    if (diperbarui == true && mounted) {
      setState(() {});
    }
  }

  void _bukaDialogUbahEmail() {
    final user = UserProfileData.currentUser;
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor:
                  _isDark ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Ubah Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Baru',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          hintText: 'Masukkan email baru',
                          icon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Masukkan format email yang valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Konfirmasi Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: _buildInputDecoration(
                          hintText: 'Masukkan password akunmu',
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setDialogState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi untuk keamanan';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
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
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        user.email = emailController.text.trim();
                      });
                      Navigator.pop(dialogContext);
                      _tampilkanNotifikasiSukses(
                        'Alamat email berhasil diubah!',
                      );
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _bukaDialogUbahTelepon() {
    final user = UserProfileData.currentUser;
    final phoneController = TextEditingController(text: user.phone);
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor:
                  _isDark ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.phone_outlined,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Ubah Nomor Telepon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nomor Telepon Baru',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: _buildInputDecoration(
                          hintText: 'Contoh: 081234567890',
                          icon: Icons.phone_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nomor telepon wajib diisi';
                          }
                          if (value.trim().length < 10) {
                            return 'Nomor telepon minimal 10 digit';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Konfirmasi Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: _buildInputDecoration(
                          hintText: 'Masukkan password akunmu',
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setDialogState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi untuk keamanan';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
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
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        user.phone = phoneController.text.trim();
                      });
                      Navigator.pop(dialogContext);
                      _tampilkanNotifikasiSukses(
                        'Nomor telepon berhasil diperbarui!',
                      );
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _bukaDialogGantiPassword() {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor:
                  _isDark ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.lock_reset,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Ganti Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password Saat Ini',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: oldPassController,
                        obscureText: obscureOld,
                        decoration: _buildInputDecoration(
                          hintText: 'Masukkan password lama',
                          icon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setDialogState(() {
                                obscureOld = !obscureOld;
                              });
                            },
                            icon: Icon(
                              obscureOld
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password lama wajib diisi';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Password Baru',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: newPassController,
                        obscureText: obscureNew,
                        decoration: _buildInputDecoration(
                          hintText: 'Minimal 6 karakter',
                          icon: Icons.key_outlined,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setDialogState(() {
                                obscureNew = !obscureNew;
                              });
                            },
                            icon: Icon(
                              obscureNew
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password baru wajib diisi';
                          }
                          if (value.length < 6) {
                            return 'Password baru minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Konfirmasi Password Baru',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: confirmPassController,
                        obscureText: obscureConfirm,
                        decoration: _buildInputDecoration(
                          hintText: 'Ulangi password baru',
                          icon: Icons.verified_user_outlined,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setDialogState(() {
                                obscureConfirm = !obscureConfirm;
                              });
                            },
                            icon: Icon(
                              obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password wajib diisi';
                          }
                          if (value != newPassController.text) {
                            return 'Konfirmasi password tidak cocok';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
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
                    if (formKey.currentState!.validate()) {
                      UserProfileData.currentUser.password =
                          newPassController.text;
                      Navigator.pop(dialogContext);
                      _tampilkanNotifikasiSukses(
                        'Password berhasil diperbarui!',
                      );
                    }
                  },
                  child: const Text(
                    'Simpan Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _tampilkanNotifikasiSukses(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(pesan)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _bukaPilihanBahasa() {
    final daftarBahasa = [
      {'label': 'Indonesia', 'sub': 'Bahasa Indonesia'},
      {'label': 'English', 'sub': 'English'},
      {'label': 'Sunda', 'sub': 'Basa Sunda'},
    ];

    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
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
                Text(
                  _tr('Pilih Bahasa', 'Select Language', 'Pilih Basa'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...daftarBahasa.map((item) {
                  final nama = item['label']!;
                  final aktif = _lang == nama;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: aktif
                          ? Colors.orange
                          : Colors.orange.shade50,
                      child: Icon(
                        Icons.language,
                        color: aktif ? Colors.white : Colors.orange,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      nama,
                      style: TextStyle(
                        fontWeight: aktif ? FontWeight.bold : FontWeight.w500,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      item['sub']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    trailing: aktif
                        ? const Icon(Icons.check_circle, color: Colors.orange)
                        : null,
                    onTap: () {
                      setState(() {
                        UserProfileData.currentUser.language = nama;
                      });
                      Navigator.pop(sheetContext);
                      _tampilkanNotifikasiSukses(
                        _tr(
                          'Bahasa diubah ke $nama',
                          'Language changed to $nama',
                          'Basa diganti ka $nama',
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bukaPilihanTema() {
    final daftarTema = [
      {
        'label': 'Light',
        'sub': _tr(
          'Tampilan terang',
          'Bright appearance',
          'Pidangan caang',
        ),
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'label': 'Dark',
        'sub': _tr(
          'Tampilan gelap nyaman di mata',
          'Dark appearance easy on the eyes',
          'Pidangan poék nyaman dina soca',
        ),
        'icon': Icons.dark_mode_outlined,
      },
    ];

    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
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
                Text(
                  _tr('Pilih Tema', 'Select Theme', 'Pilih Téma'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...daftarTema.map((item) {
                  final nama = item['label'] as String;
                  final aktif = UserProfileData.currentUser.theme == nama;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: aktif
                          ? Colors.orange
                          : Colors.orange.shade50,
                      child: Icon(
                        item['icon'] as IconData,
                        color: aktif ? Colors.white : Colors.orange,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      nama,
                      style: TextStyle(
                        fontWeight: aktif ? FontWeight.bold : FontWeight.w500,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      item['sub'] as String,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    trailing: aktif
                        ? const Icon(Icons.check_circle, color: Colors.orange)
                        : null,
                    onTap: () {
                      setState(() {
                        UserProfileData.currentUser.theme = nama;
                      });
                      Navigator.pop(sheetContext);
                      _tampilkanNotifikasiSukses(
                        _tr(
                          'Tema diubah ke $nama',
                          'Theme changed to $nama',
                          'Téma diganti ka $nama',
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _bukaHalamanFaq() {
    final daftarFaq = [
      {
        'q': _tr(
          'Apa itu aplikasi Bandung Foodies?',
          'What is Bandung Foodies?',
          'Naon ari aplikasi Bandung Foodies?',
        ),
        'a': _tr(
          'Bandung Foodies adalah panduan kuliner lokal untuk menemukan seblak, bakso, mie ayam, rumah makan Sunda, dan cafe terbaik di berbagai kawasan Bandung.',
          'Bandung Foodies is a local culinary guide to discover the best seblak, meatballs, noodles, Sundanese restaurants, and cafes around Bandung.',
          'Bandung Foodies nyaéta panduan kuliner lokal pikeun manggihan seblak, baso, mie ayam, rumah makan Sunda, sareng cafe pangsaéna di Bandung.',
        ),
      },
      {
        'q': _tr(
          'Bagaimana cara menyimpan tempat makan ke Favorit?',
          'How do I save a restaurant to Favorites?',
          'Kumaha cara nyimpen tempat tuang ka Karesep?',
        ),
        'a': _tr(
          'Kamu cukup menekan ikon hati berwarna oranye pada kartu tempat makan di halaman Home atau Search.',
          'Simply tap the orange heart icon on any food card on the Home or Search page.',
          'Cekap pencét ikon haté warna oranyeu dina kartu tempat tuang di kaca Home atanapi Search.',
        ),
      },
      {
        'q': _tr(
          'Apakah rute di menu Maps memerlukan GPS aktif?',
          'Does the route in Maps require active GPS?',
          'Naha rute dina Maps peryogi GPS aktif?',
        ),
        'a': _tr(
          'Tidak. Peta dan estimasi waktu tempuh di aplikasi ini berjalan secara lokal sebagai simulasi visual.',
          'No. The map and travel time estimation run locally as a visual simulation.',
          'Henteu. Peta sareng estimasi waktos di aplikasi ieu jalan sacara lokal salaku simulasi visual.',
        ),
      },
      {
        'q': _tr(
          'Bagaimana cara mengubah email atau password akun?',
          'How do I change my account email or password?',
          'Kumaha cara ngaganti email atanapi password akun?',
        ),
        'a': _tr(
          'Kamu bisa masuk ke bagian Keamanan Akun di halaman Profil, lalu pilih menu Ubah Email atau Ganti Password.',
          'Go to the Account Security section on the Profile page, then select Change Email or Change Password.',
          'Lebet ka bagian Kaamanan Akun di kaca Profil, teras pilih menu Ganti Email atanapi Ganti Password.',
        ),
      },
    ];

    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardBg = _isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final borderColor = _isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: sheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          maxChildSize: 0.85,
          minChildSize: 0.4,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              child: Column(
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
                  Text(
                    'FAQ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _tr(
                      'Jawaban cepat seputar penggunaan Bandung Foodies',
                      'Quick answers about using Bandung Foodies',
                      'Jawaban gancang ngeunaan Bandung Foodies',
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: daftarFaq.length,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final item = daftarFaq[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),
                          child: ExpansionTile(
                            iconColor: Colors.orange,
                            collapsedIconColor: Colors.grey,
                            title: Text(
                              item['q']!,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: textColor,
                              ),
                            ),
                            childrenPadding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              14,
                            ),
                            children: [
                              Text(
                                item['a']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _bukaInfoDokumen({
    required String judul,
    required String subjudul,
    required List<Map<String, String>> poin,
  }) {
    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardBg = _isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final borderColor = _isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: sheetBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          maxChildSize: 0.85,
          minChildSize: 0.4,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              child: Column(
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
                  Text(
                    judul,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subjudul,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: poin.length,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final item = poin[index];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['judul']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['isi']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: textColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _konfirmasiClearCache() {
    if (_cacheSize == '0.0 MB') {
      _tampilkanNotifikasiSukses(
        _tr(
          'Cache aplikasi sudah bersih (0.0 MB).',
          'App cache is already clean (0.0 MB).',
          'Cache aplikasi atos beresih (0.0 MB).',
        ),
      );
      return;
    }

    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: sheetBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.cleaning_services_outlined,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Clear Cache',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            _tr(
              'Hapus file sementara sebesar $_cacheSize? Data profil dan akun kamu tidak akan terhapus.',
              'Delete $_cacheSize of temporary files? Your profile and account data will not be deleted.',
              'Hapus file saheulaanan ageungna $_cacheSize? Data profil sareng akun moal kahapus.',
            ),
            style: TextStyle(fontSize: 13, color: textColor),
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
                final ukuranLama = _cacheSize;
                setState(() {
                  _cacheSize = '0.0 MB';
                });
                Navigator.pop(dialogContext);
                _tampilkanNotifikasiSukses(
                  _tr(
                    'Berhasil membersihkan cache sebesar $ukuranLama!',
                    'Successfully cleared $ukuranLama of cache!',
                    'Hasil meresihan cache ageungna $ukuranLama!',
                  ),
                );
              },
              child: Text(
                _tr('Bersihkan', 'Clear', 'Beresihan'),
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

  void _konfirmasiLogout() {
    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: sheetBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.logout, color: Colors.red, size: 22),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: textColor,
                ),
              ),
            ],
          ),
          content: Text(
            _tr(
              'Apakah kamu yakin ingin keluar dari akun Bandung Foodies?',
              'Are you sure you want to log out of Bandung Foodies?',
              'Naha anjeun yakin badé kaluar ti akun Bandung Foodies?',
            ),
            style: TextStyle(fontSize: 14, color: textColor),
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
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _tr(
                        'Berhasil keluar dari akun.',
                        'Successfully logged out.',
                        'Hasil kaluar ti akun.',
                      ),
                    ),
                    backgroundColor: Colors.orange.shade800,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: Text(
                _tr('Ya, Keluar', 'Yes, Logout', 'Muhun, Kaluar'),
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

  void _konfirmasiHapusAkun() {
    final sheetBg = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: sheetBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.delete_forever_outlined, color: Colors.red, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _tr('Hapus Akun', 'Delete Account', 'Hapus Akun'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            _tr(
              'Tindakan ini bersifat permanen. Semua data profil, ulasan, dan daftar favoritmu akan dihapus. Apakah kamu yakin ingin menghapus akun?',
              'This action is permanent. All your profile data, reviews, and favorites will be deleted. Are you sure you want to delete your account?',
              'Tindakan ieu sipatna permanén. Sadaya data profil, ulasan, sareng karesep anjeun bakal dihapus. Naha anjeun yakin badé ngahapus akun?',
            ),
            style: TextStyle(fontSize: 13.5, color: textColor, height: 1.4),
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
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _tr(
                        'Akun kamu telah berhasil dihapus.',
                        'Your account has been permanently deleted.',
                        'Akun anjeun parantos hasil dihapus.',
                      ),
                    ),
                    backgroundColor: Colors.red.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: Text(
                _tr('Hapus Permanen', 'Delete Permanently', 'Hapus Permanén'),
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

  @override
  Widget build(BuildContext context) {
    final user = UserProfileData.currentUser;
    final bgColor = _isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final subBoxColor =
        _isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final borderColor =
        _isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final shadowColor =
        _isDark ? Colors.black.withValues(alpha: 0.35) : Colors.grey.shade200;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Atas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tr(
                      'Akun Bandung Foodies',
                      'Bandung Foodies Account',
                      'Akun Bandung Foodies',
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _tr('Profil Pengguna', 'User Profile', 'Profil Pamaké'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Kartu Utama Foto & Identitas Singkat Pengguna (Tanpa Ikon Kamera, Hanya Border Kuning/Oranye)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.amber.shade600,
                              width: 2.5,
                            ),
                          ),
                          child: ClipOval(
                            child: user.avatarUrl.isEmpty
                                ? Container(
                                    width: 72,
                                    height: 72,
                                    color: Colors.orange.shade50,
                                    child: const Icon(
                                      Icons.person,
                                      size: 38,
                                      color: Colors.orange,
                                    ),
                                  )
                                : Image.network(
                                    user.avatarUrl,
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 72,
                                        height: 72,
                                        color: Colors.orange.shade50,
                                        child: const Icon(
                                          Icons.person,
                                          size: 38,
                                          color: Colors.orange,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isDark
                                          ? Colors.orange.withValues(alpha: 0.15)
                                          : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.orange,
                                          size: 13,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${user.location}, Bandung',
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: subBoxColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.bio,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _bukaEditProfil,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          _tr('Edit Profil', 'Edit Profile', 'Édit Profil'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. Statistik Kuliner Pengguna
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.favorite,
                      iconColor: Colors.red,
                      bgColor: Colors.red.shade50,
                      value: '6',
                      label: _tr('Favorit', 'Favorites', 'Karesep'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.rate_review,
                      iconColor: Colors.amber.shade800,
                      bgColor: Colors.amber.shade50,
                      value: '12',
                      label: _tr('Ulasan', 'Reviews', 'Ulasan'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReviewsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.restaurant_menu,
                      iconColor: Colors.teal,
                      bgColor: Colors.teal.shade50,
                      value: user.favoriteCategory,
                      label: _tr('Selera Utama', 'Top Craving', 'Karesep Utama'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(
                              initialCategory: user.favoriteCategory,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 4. Keamanan Akun (Account Security)
              Text(
                _tr(
                  'Keamanan Akun',
                  'Account Security',
                  'Kaamanan Akun',
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuTile(
                      icon: Icons.email_outlined,
                      title: _tr('Ubah Email', 'Change Email', 'Ganti Email'),
                      subtitle: user.email,
                      onTap: _bukaDialogUbahEmail,
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildMenuTile(
                      icon: Icons.phone_android_outlined,
                      title: _tr(
                        'Ubah Nomor Telepon',
                        'Change Phone Number',
                        'Ganti Nomor Telepon',
                      ),
                      subtitle: user.phone,
                      onTap: _bukaDialogUbahTelepon,
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildMenuTile(
                      icon: Icons.lock_outline,
                      title: _tr(
                        'Ganti Password',
                        'Change Password',
                        'Ganti Password',
                      ),
                      subtitle: _tr(
                        'Perbarui password keamanan akun kamu',
                        'Update your account security password',
                        'Anyarkeun password kaamanan akun anjeun',
                      ),
                      onTap: _bukaDialogGantiPassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // 5. Preferensi (Language, Theme, Notifications, Location)
              Text(
                _tr('Preferensi', 'Preferences', 'Preferénsi'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuTile(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: user.language,
                      onTap: _bukaPilihanBahasa,
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildMenuTile(
                      icon: Icons.palette_outlined,
                      title: 'Theme',
                      subtitle: user.theme,
                      onTap: _bukaPilihanTema,
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildSwitchTile(
                      icon: Icons.notifications_active_outlined,
                      title: _tr(
                        'Notifikasi Kuliner',
                        'Culinary Notifications',
                        'Notifikasi Kuliner',
                      ),
                      subtitle: _tr(
                        'Info tempat makan baru & kuliner hits Bandung',
                        'New dining spots & trending food in Bandung',
                        'Inpormasi tempat tuang énggal di Bandung',
                      ),
                      value: _notifPromo,
                      onChanged: (val) {
                        setState(() {
                          _notifPromo = val;
                        });
                      },
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildSwitchTile(
                      icon: Icons.my_location_outlined,
                      title: _tr(
                        'Lokasi Otomatis',
                        'Auto Location',
                        'Lokasi Otomatis',
                      ),
                      subtitle: _tr(
                        'Rekomendasikan kuliner terdekat di Bandung',
                        'Recommend nearby culinary spots in Bandung',
                        'Rekomendasikeun kuliner pangcaketna di Bandung',
                      ),
                      value: _autoLocation,
                      onChanged: (val) {
                        setState(() {
                          _autoLocation = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // 6. Bantuan & Informasi (FAQ, Terms of Use, Privacy Policy)
              Text(
                _tr(
                  'Bantuan & Informasi',
                  'Help & Information',
                  'Bantuan & Inpormasi',
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuTile(
                      icon: Icons.help_outline,
                      title: 'FAQ',
                      subtitle: _tr(
                        'Panduan penggunaan & tanya jawab aplikasi',
                        'Usage guide & frequently asked questions',
                        'Panduan pamakéan & tanya jawab aplikasi',
                      ),
                      onTap: _bukaHalamanFaq,
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildMenuTile(
                      icon: Icons.description_outlined,
                      title: 'Terms of Use',
                      subtitle: _tr(
                        'Syarat dan ketentuan layanan Bandung Foodies',
                        'Bandung Foodies terms and conditions of service',
                        'Syarat sareng katangtosan layanan Bandung Foodies',
                      ),
                      onTap: () {
                        _bukaInfoDokumen(
                          judul: 'Terms of Use',
                          subjudul: _tr(
                            'Ketentuan penggunaan aplikasi Bandung Foodies',
                            'Terms of use for Bandung Foodies application',
                            'Katangtosan pamakéan aplikasi Bandung Foodies',
                          ),
                          poin: [
                            {
                              'judul': _tr(
                                '1. Penggunaan Layanan',
                                '1. Use of Service',
                                '1. Pamakéan Layanan',
                              ),
                              'isi': _tr(
                                'Aplikasi Bandung Foodies disediakan untuk membantu pengguna mencari informasi tempat kuliner, ulasan, dan rute di kawasan Bandung.',
                                'Bandung Foodies is provided to help users find culinary spots, reviews, and routes across Bandung.',
                                'Aplikasi Bandung Foodies disadiakeun pikeun ngabantosan pamaké milarian tempat kuliner, ulasan, sareng rute di Bandung.',
                              ),
                            },
                            {
                              'judul': _tr(
                                '2. Etika Ulasan & Komentar',
                                '2. Review & Comment Ethics',
                                '2. Étika Ulasan & Koméntar',
                              ),
                              'isi': _tr(
                                'Pengguna wajib memberikan ulasan kuliner secara jujur, sopan, dan tidak mengandung unsur SARA maupun ujaran kebencian.',
                                'Users must provide honest, polite culinary reviews free from hate speech or offensive content.',
                                'Pamaké wajib masihan ulasan kuliner sacara jujur sareng sopan.',
                              ),
                            },
                            {
                              'judul': _tr(
                                '3. Keakuratan Informasi Kuliner',
                                '3. Culinary Information Accuracy',
                                '3. Kaakuratan Inpormasi Kuliner',
                              ),
                              'isi': _tr(
                                'Rentang harga dan jam operasional tempat makan disajikan sebagai referensi dan dapat berubah sewaktu-waktu sesuai kebijakan pemilik resto.',
                                'Price ranges and opening hours are provided for reference and may change according to restaurant policies.',
                                'Rentang pangaos sareng jam buka disajikeun salaku réferénsi.',
                              ),
                            },
                          ],
                        );
                      },
                    ),
                    Divider(height: 1, color: borderColor),
                    _buildMenuTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subtitle: _tr(
                        'Kebijakan privasi & perlindungan data pengguna',
                        'Privacy policy & user data protection',
                        'Kabijakan privasi & panangtayungan data pamaké',
                      ),
                      onTap: () {
                        _bukaInfoDokumen(
                          judul: 'Privacy Policy',
                          subjudul: _tr(
                            'Bagaimana Bandung Foodies menjaga privasi datamu',
                            'How Bandung Foodies protects your data privacy',
                            'Kumaha Bandung Foodies ngajaga privasi data anjeun',
                          ),
                          poin: [
                            {
                              'judul': _tr(
                                '1. Data Profil Pengguna',
                                '1. User Profile Data',
                                '1. Data Profil Pamaké',
                              ),
                              'isi': _tr(
                                'Informasi seperti nama, email, nomor telepon, dan preferensi kuliner disimpan secara aman hanya untuk keperluan personalisasi akunmu.',
                                'Information such as name, email, phone number, and culinary preferences are stored securely to personalize your account.',
                                'Inpormasi sapertos nami, email, nomor telepon, sareng karesep kuliner disimpen sacara aman.',
                              ),
                            },
                            {
                              'judul': _tr(
                                '2. Privasi Lokasi',
                                '2. Location Privacy',
                                '2. Privasi Lokasi',
                              ),
                              'isi': _tr(
                                'Data kawasan Bandung yang kamu pilih digunakan untuk memfilter rekomendasi kuliner terdekat dan tidak dibagikan ke pihak ketiga.',
                                'Your selected Bandung area is used to filter nearby culinary recommendations and is not shared with third parties.',
                                'Data wewengkon Bandung anu dipilih dianggo pikeun nyaring rekomendasi kuliner caket.',
                              ),
                            },
                            {
                              'judul': _tr(
                                '3. Keamanan Akun',
                                '3. Account Security',
                                '3. Kaamanan Akun',
                              ),
                              'isi': _tr(
                                'Kamu memiliki kendali penuh untuk mengubah email, nomor telepon, password, maupun menghapus cache aplikasi kapan saja.',
                                'You have full control to update your email, phone number, password, or clear app cache at any time.',
                                'Anjeun gaduh kadali pinuh pikeun ngaganti email, nomor telepon, password, atanapi meresihan cache.',
                              ),
                            },
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // 7. Penyimpanan & Clear Cache
              Text(
                _tr('Penyimpanan', 'Storage', 'Panyimpenan'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: _konfirmasiClearCache,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: _isDark
                          ? Colors.orange.withValues(alpha: 0.15)
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.cleaning_services_outlined,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'Clear Cache',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    _tr(
                      'Hapus data gambar & pencarian sementara',
                      'Delete temporary image & search data',
                      'Hapus data gambar & pilarian saheulaanan',
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _cacheSize == '0.0 MB'
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _cacheSize,
                      style: TextStyle(
                        color: _cacheSize == '0.0 MB'
                            ? Colors.green.shade700
                            : Colors.orange.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 8. Tombol Logout
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                    backgroundColor: _isDark
                        ? Colors.red.withValues(alpha: 0.12)
                        : Colors.red.shade50,
                    side: BorderSide(
                      color: _isDark
                          ? Colors.red.shade900
                          : Colors.red.shade200,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _konfirmasiLogout,
                  icon: const Icon(Icons.logout, size: 20),
                  label: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 9. Teks kecil merah Delete Account di paling bawah (bukan button)
              Center(
                child: GestureDetector(
                  onTap: _konfirmasiHapusAkun,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      _tr('Hapus Akun', 'Delete Account', 'Hapus Akun'),
                      style: TextStyle(
                        color: Colors.red.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 95),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    final cardColor = _isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDark ? Colors.white : Colors.black87;
    final borderColor =
        _isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final shadowColor =
        _isDark ? Colors.black.withValues(alpha: 0.35) : Colors.grey.shade200;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final textColor = _isDark ? Colors.white : Colors.black87;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: _isDark
              ? Colors.orange.withValues(alpha: 0.15)
              : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final textColor = _isDark ? Colors.white : Colors.black87;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: _isDark
              ? Colors.orange.withValues(alpha: 0.15)
              : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
      trailing: Switch(
        value: value,
        activeThumbColor: Colors.white,
        activeTrackColor: Colors.orange,
        onChanged: onChanged,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final fillColor = _isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100;
    final borderColor =
        _isDark ? Colors.grey.shade700 : Colors.grey.shade300;
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      prefixIcon: Icon(icon, color: Colors.orange, size: 18),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
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
