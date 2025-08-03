import 'package:flutter/material.dart';
import '../ui/selametan_page.dart';
import '../ui/weton_page.dart';
import '../ui/bantuan_page.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            "Selamat datang!",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            "Aplikasi ini membantu Anda menghitung hari-hari penting berdasarkan tradisi Jawa seperti selamatan, weton, dan lainnya.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _buildMenuCard(
            context,
            title: "Kalkulator Selametan",
            description: "Hitung tanggal selamatan berdasarkan hari kematian dan jumlah hari tertentu.",
            icon: Icons.calendar_today,
            destination: const HitungSelametanPage(), // ganti dengan page kamu
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            title: "Hitung Weton",
            description: "Cek weton berdasarkan tanggal lahir.",
            icon: Icons.event_note,
            destination: const WetonPage(), // ganti dengan page kamu
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            title: "Bantuan Penggunaan",
            description: "Panduan menggunakan aplikasi ini dengan mudah.",
            icon: Icons.help_outline,
            destination: const BantuanPage(), // ganti dengan page kamu
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Widget destination,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
