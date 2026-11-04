import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';

void showSuccess(BuildContext context, String action) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Berhasil'),
      content: Text(action),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Teman kuliner')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
      children: [
        const Text('Cari teman untuk berbagi rekomendasi tempat makan.'),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Cari nama atau username',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Daftar teman • 2',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (final name in ['Dinda Putri', 'Rizky Pratama'])
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(name[0])),
              title: Text(name),
              subtitle: const Text('Suka kuliner Bandung'),
              trailing: const Chip(label: Text('Teman')),
            ),
          ),
        const SizedBox(height: 20),
        const Text(
          'Rekomendasi teman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Andi Saputra'),
            subtitle: const Text('@andikuliner'),
            trailing: IconButton(
              tooltip: 'Tambah teman',
              icon: const Icon(Icons.person_add_alt),
              onPressed: () => showSuccess(
                context,
                'Permintaan pertemanan berhasil dikirim ke Andi.',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class PlaceFormPage extends StatelessWidget {
  final bool admin;
  const PlaceFormPage({super.key, this.admin = false});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(admin ? 'Tambah tempat makan' : 'Ajukan tempat makan'),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
      children: [
        Text(
          admin
              ? 'Lengkapi informasi tempat untuk katalog kuliner.'
              : 'Punya tempat favorit? Ajukan untuk ditinjau admin.',
        ),
        const SizedBox(height: 20),
        for (final label in [
          'Nama tempat',
          'Alamat lengkap',
          'Kategori kuliner',
          'Kisaran harga',
          'Jam buka',
          'Tautan Google Maps',
          'Deskripsi',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextField(
              maxLines: label == 'Deskripsi' ? 3 : 1,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        OutlinedButton.icon(
          onPressed: () =>
              showSuccess(context, 'Foto tempat berhasil ditambahkan.'),
          icon: const Icon(Icons.add_photo_alternate_outlined),
          label: const Text('Tambahkan foto'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => showSuccess(
            context,
            admin ? 'Tempat makan berhasil ditambahkan ke katalog.' : 'Pengajuan berhasil dikirim. Silakan tunggu peninjauan admin.',
          ),
          child: Text(admin ? 'Simpan tempat' : 'Kirim pengajuan'),
        ),
        if (!admin) ...[
          const SizedBox(height: 28),
          const Text(
            'Riwayat pengajuan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Card(
            child: ListTile(
              title: Text('Warung Nasi Teh Sari'),
              subtitle: Text('Menunggu peninjauan admin'),
              leading: Icon(Icons.schedule, color: Colors.orange),
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Kedai Kopi Kampus'),
              subtitle: Text('Disetujui'),
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Bakso Pak Budi'),
              subtitle: Text('Ditolak • Alamat perlu dilengkapi'),
              leading: Icon(Icons.info_outline, color: Colors.red),
            ),
          ),
        ],
      ],
    ),
  );
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Kelola tempat makan')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 112),
      children: [
        const Text(
          'Kelola tempat makan',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text('Kelola katalog dan tinjau rekomendasi dari pengguna.'),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const PlaceFormPage(admin: true),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Tambah tempat makan'),
        ),
        const SizedBox(height: 24),
        const Text(
          'Pengajuan masuk • 1',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Warung Nasi Teh Sari',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Diajukan oleh Dinda Putri\nJl. Sukabirus, Bandung\nSunda • Rp15rb - Rp25rb\nBuka 08.00 - 20.00 WIB',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: () => showSuccess(
                        context,
                        'Pengajuan Warung Nasi Teh Sari berhasil disetujui.',
                      ),
                      icon: const Icon(Icons.check),
                      label: const Text('Setujui'),
                    ),
                    OutlinedButton(
                      onPressed: () => showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Alasan penolakan'),
                          content: const TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Contoh: alamat belum lengkap',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                showSuccess(
                                  context,
                                  'Pengajuan tempat makan berhasil ditolak.',
                                );
                              },
                              child: const Text('Tolak'),
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Tolak'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Katalog tempat makan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (final item in dummyRestaurants)
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(item.name),
              subtitle: Text('${item.category} • ${item.location}'),
              trailing: const Chip(label: Text('Tayang')),
            ),
          ),
      ],
    ),
  );
}
