import 'package:flutter/material.dart';

/// Placeholder Halaman Review & Tulis Review (Bagian Orang 4)
class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review & Komentar')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halaman Review & Tulis Review\n(Bagian Orang 4 — Dikosongkan sementara)',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
