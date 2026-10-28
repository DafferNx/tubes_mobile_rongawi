import 'package:flutter/material.dart';

import '../../core/widgets/category_chip.dart';
import '../../data/dummy_restaurants.dart';

/// Model data pengguna untuk berbagi state antar halaman (Bagian Orang 5)
class UserProfileData {
  String fullName;
  String email;
  String phone;
  String? _password;
  String location;
  String bio;
  String favoriteCategory;
  String avatarUrl;
  String? uploadedFileName;
  String? _language;
  String? _theme;

  String get password => _password ?? 'bandung123';
  set password(String value) => _password = value;

  String get language => _language ?? 'Indonesia';
  set language(String value) {
    _language = value;
    notifySettingsChanged();
  }

  String get theme => _theme ?? 'Light';
  set theme(String value) {
    _theme = value;
    notifySettingsChanged();
  }

  bool get isDark => theme == 'Dark';

  /// Notifier global (aman terhadap Hot Reload) agar perubahan Theme & Language langsung memperbarui seluruh halaman
  static ValueNotifier<int>? _settingsNotifier;
  static ValueNotifier<int> get settingsNotifier =>
      _settingsNotifier ??= ValueNotifier<int>(0);

  static void notifySettingsChanged() {
    settingsNotifier.value++;
  }

  static bool get isDarkMode => currentUser.isDark;

  static String tr(String id, String en, [String? su]) {
    final lang = currentUser.language;
    if (lang == 'English') return en;
    if (lang == 'Sunda') return su ?? id;
    return id;
  }

  UserProfileData({
    required this.fullName,
    required this.email,
    required this.phone,
    String password = 'bandung123',
    required this.location,
    required this.bio,
    required this.favoriteCategory,
    required this.avatarUrl,
    this.uploadedFileName,
    String language = 'Indonesia',
    String theme = 'Light',
  }) : _password = password,
       _language = language,
       _theme = theme;

  /// State global sederhana agar perubahan profil/keamanan tersimpan selama aplikasi berjalan
  static UserProfileData currentUser = UserProfileData(
    fullName: 'Raka Pratama',
    email: 'raka.foodies@bandung.id',
    phone: '081234567890',
    password: 'bandung123',
    location: 'Dago',
    bio: 'Pecinta kuliner pedas dan kopi susu gula aren di sudut kota Bandung.',
    favoriteCategory: 'Seblak',
    avatarUrl: 'https://picsum.photos/id/64/300/300',
    language: 'Indonesia',
    theme: 'Light',
  );
}

/// Halaman Edit Profile (Bagian Orang 5)
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _bioController;

  late String _selectedLocation;
  late String _selectedCategory;
  late String _selectedAvatar;
  String? _uploadedFileName;

  // Daftar lokasi Bandung tanpa 'Semua Lokasi'
  List<String> get _pilihanLokasi =>
      lokasiBandung.where((lok) => lok != 'Semua Lokasi').toList();

  // Daftar kategori kuliner tanpa 'Semua'
  List<String> get _pilihanKategori =>
      kategoriKuliner.where((kat) => kat != 'Semua').toList();

  @override
  void initState() {
    super.initState();
    final user = UserProfileData.currentUser;
    _nameController = TextEditingController(text: user.fullName);
    _bioController = TextEditingController(text: user.bio);

    _selectedLocation = _pilihanLokasi.contains(user.location)
        ? user.location
        : _pilihanLokasi.first;
    _selectedCategory = _pilihanKategori.contains(user.favoriteCategory)
        ? user.favoriteCategory
        : _pilihanKategori.first;
    _selectedAvatar = user.avatarUrl;
    _uploadedFileName = user.uploadedFileName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _bukaMenuUploadFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Upload Foto Profil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pilih sumber foto profil yang ingin kamu gunakan',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text(
                    'Pilih dari Galeri Perangkat',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Upload file gambar (JPG / PNG) dari HP kamu',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pilihFileDariPerangkat(dariKamera: false);
                  },
                ),
                const Divider(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text(
                    'Ambil Foto dengan Kamera',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Gunakan kamera untuk mengambil foto baru',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pilihFileDariPerangkat(dariKamera: true);
                  },
                ),
                const Divider(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.link,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text(
                    'Masukkan Link / URL Foto Sendiri',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Gunakan tautan gambar langsung milikmu',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _tampilkanDialogUrlFoto();
                  },
                ),
                if (_selectedAvatar.isNotEmpty) ...[
                  const Divider(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    title: const Text(
                      'Hapus Foto Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    subtitle: const Text(
                      'Gunakan ikon profil standar tanpa foto',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      setState(() {
                        _selectedAvatar = '';
                        _uploadedFileName = null;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _pilihFileDariPerangkat({required bool dariKamera}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch % 10000;
    final simulatedId = (timestamp % 70) + 10;
    setState(() {
      _selectedAvatar = 'https://picsum.photos/id/$simulatedId/300/300';
      _uploadedFileName = dariKamera
          ? 'CAM_$timestamp.jpg'
          : 'IMG_Gallery_$timestamp.jpg';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Foto $_uploadedFileName berhasil dipilih'),
        backgroundColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _tampilkanDialogUrlFoto() {
    final urlController = TextEditingController(text: _selectedAvatar);
    final urlFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Upload via URL Foto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: Form(
            key: urlFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: urlController,
              decoration: _buildInputDecoration(
                hintText: 'https://contoh.com/foto-saya.jpg',
                icon: Icons.link,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'URL foto tidak boleh kosong';
                }
                if (!value.trim().startsWith('http')) {
                  return 'Masukkan URL yang diawali http:// atau https://';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
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
                if (urlFormKey.currentState!.validate()) {
                  setState(() {
                    _selectedAvatar = urlController.text.trim();
                    _uploadedFileName = 'Custom_URL_Photo.jpg';
                  });
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text(
                'Gunakan Foto',
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
  }

  void _simpanProfil() {
    if (_formKey.currentState!.validate()) {
      final user = UserProfileData.currentUser;
      user.fullName = _nameController.text.trim();
      user.bio = _bioController.text.trim();
      user.location = _selectedLocation;
      user.favoriteCategory = _selectedCategory;
      user.avatarUrl = _selectedAvatar;
      user.uploadedFileName = _uploadedFileName;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Expanded(child: Text('Profil berhasil diperbarui!')),
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
    final user = UserProfileData.currentUser;
    final isDark = user.isDark;
    final lang = user.language;

    String tr(String id, String en, [String? su]) {
      if (lang == 'English') return en;
      if (lang == 'Sunda') return su ?? id;
      return id;
    }

    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final fieldFill = isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor =
        isDark ? Colors.grey.shade800 : Colors.grey.shade300;

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
              backgroundColor: fieldFill,
              child: Icon(Icons.chevron_left, color: textColor),
            ),
          ),
        ),
        title: Text(
          tr('Edit Profil', 'Edit Profile', 'Édit Profil'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Bagian Upload Foto Profil Sendiri (Langsung Pencet Foto)
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _bukaMenuUploadFoto,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.amber.shade600,
                                  width: 2.5,
                                ),
                              ),
                              child: ClipOval(
                                child: _selectedAvatar.isEmpty
                                    ? Container(
                                        width: 96,
                                        height: 96,
                                        color: Colors.orange.shade50,
                                        child: const Icon(
                                          Icons.person,
                                          size: 48,
                                          color: Colors.orange,
                                        ),
                                      )
                                    : Image.network(
                                        _selectedAvatar,
                                        width: 96,
                                        height: 96,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 96,
                                            height: 96,
                                            color: Colors.orange.shade50,
                                            child: const Icon(
                                              Icons.person,
                                              size: 48,
                                              color: Colors.orange,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_uploadedFileName != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'File: $_uploadedFileName',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Form Informasi Profil (Tanpa Email & Telepon)
                Text(
                  tr('Informasi Profil', 'Profile Information', 'Inpormasi Profil'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 14),

                _buildFieldLabel(
                  tr('Nama Lengkap', 'Full Name', 'Nami Lengkep'),
                  textColor,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: tr(
                      'Masukkan nama lengkap',
                      'Enter full name',
                      'Lebetkeun nami lengkep',
                    ),
                    icon: Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return tr(
                        'Nama lengkap tidak boleh kosong',
                        'Full name cannot be empty',
                        'Nami lengkep teu kénging kosong',
                      );
                    }
                    if (value.trim().length < 3) {
                      return tr(
                        'Nama minimal 3 karakter',
                        'Name must be at least 3 characters',
                        'Nami minimal 3 karakter',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3. Pilihan Lokasi di Bandung
                _buildFieldLabel(
                  tr(
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
                    color: fieldFill,
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
                          dropdownColor: fieldFill,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: _pilihanLokasi.map((lokasi) {
                            return DropdownMenuItem<String>(
                              value: lokasi,
                              child: Text(
                                '$lokasi, Bandung',
                                style: TextStyle(fontSize: 14, color: textColor),
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

                // 4. Bio Singkat
                _buildFieldLabel(
                  tr('Bio Kuliner', 'Culinary Bio', 'Bio Kuliner'),
                  textColor,
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  style: TextStyle(color: textColor),
                  decoration: _buildInputDecoration(
                    hintText: tr(
                      'Ceritakan selera kulinermu di Bandung...',
                      'Share your culinary taste in Bandung...',
                      'Caritakeun karesep kuliner anjeun di Bandung...',
                    ),
                    icon: Icons.edit_note_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return tr(
                        'Bio singkat tidak boleh kosong',
                        'Bio cannot be empty',
                        'Bio teu kénging kosong',
                      );
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // 5. Kategori Kuliner Favorit (Menggunakan CategoryChip proyek)
                _buildFieldLabel(
                  tr(
                    'Kuliner Favorit Utama',
                    'Favorite Culinary Category',
                    'Kuliner Karesep Utama',
                  ),
                  textColor,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _pilihanKategori.map((kategori) {
                    return CategoryChip(
                      label: kategori,
                      isSelected: _selectedCategory == kategori,
                      onTap: () {
                        setState(() {
                          _selectedCategory = kategori;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // 6. Tombol Simpan & Batal
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
                    onPressed: _simpanProfil,
                    child: Text(
                      tr('Simpan Perubahan', 'Save Changes', 'Simpen Parobahan'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      tr('Batal', 'Cancel', 'Batal'),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, [Color? color]) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: color ?? Colors.black87,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    final isDark = UserProfileData.currentUser.isDark;
    final fillColor = isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;
    final borderColor =
        isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.orange, size: 20),
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
