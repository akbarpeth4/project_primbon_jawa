// import 'package:flutter/material.dart';
// import '../services/hari_pasaran_calculator.dart';
// import '../widgets/dropdown_variants.dart';
// import '../widgets/tanggal_input.dart'; // pastikan file ini ada
// import '../models/hari_variants.dart';
// import '../utils/tanggal_utils.dart';   // untuk format tanggal

// class HariPasaranPage extends StatefulWidget {
//   const HariPasaranPage({super.key});

//   @override
//   State<HariPasaranPage> createState() => _HariPasaranPageState();
// }

// class _HariPasaranPageState extends State<HariPasaranPage> {
//   String selectedHari = "Ahad";
//   String selectedPasaran = "Legi";
//   int jumlahHari = 1;
//   bool isManual = false;

//   HariVariant? selectedVariant;
//   String hasilHari = "";
//   String hasilPasaran = "";

//   DateTime? selectedTanggalAwal;
//   DateTime? hasilTanggalAkhir;

//   final List<String> hariList = ["Ahad", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
//   final List<String> pasaranList = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

//   void hitungHariPasaran() {
//     int hariYangDipakai = isManual ? jumlahHari : selectedVariant?.days ?? 1;

//     final calculator = HariPasaranCalculator(selectedHari, selectedPasaran);
//     final result = calculator.hitung(hariYangDipakai);

//     setState(() {
//       hasilHari = result.hari;
//       hasilPasaran = result.pasaran;

//       // Hitung tanggal akhir juga
//       if (selectedTanggalAwal != null) {
//         hasilTanggalAkhir = selectedTanggalAwal!.add(Duration(days: hariYangDipakai-1));
//       } else {
//         hasilTanggalAkhir = null;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hitung Selametan Hari Kematian'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
                  

//                   // Hari dan Pasaran Awal
//                   DropdownButtonFormField<String>(
//                     value: selectedHari,
//                     items: hariList.map((String value) {
//                       return DropdownMenuItem(value: value, child: Text(value));
//                     }).toList(),
//                     decoration: const InputDecoration(labelText: "Hari Awal"),
//                     onChanged: (value) {
//                       setState(() => selectedHari = value!);
//                     },
//                   ),
//                   DropdownButtonFormField<String>(
//                     value: selectedPasaran,
//                     items: pasaranList.map((String value) {
//                       return DropdownMenuItem(value: value, child: Text(value));
//                     }).toList(),
//                     decoration: const InputDecoration(labelText: "Pasaran Awal"),
//                     onChanged: (value) {
//                       setState(() => selectedPasaran = value!);
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   // Tanggal Awal
//                   TanggalInput(
//                     selectedDate: selectedTanggalAwal,
//                     jumlahHari: isManual ? jumlahHari : selectedVariant?.days ?? 1,
//                     namaHariInput: selectedHari,
//                     onDateSelected: (picked) => setState(() => selectedTanggalAwal = picked),
//                     onTanggalHasilChanged: (hasilDate) => setState(() => hasilTanggalAkhir = hasilDate),
//                   ),
//                   const SizedBox(height: 16),
//                   // Variant Dropdown
//                   VariantDropdown(
//                     selected: selectedVariant,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedVariant = value;
//                         isManual = value?.label == "Manual";
//                         if (!isManual) jumlahHari = value?.days ?? 1;
//                       });
//                     },
//                   ),

//                   if (isManual)
//                     TextFormField(
//                       initialValue: jumlahHari.toString(),
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(labelText: "Jumlah Hari (Manual)"),
//                       onChanged: (value) {
//                         jumlahHari = int.tryParse(value) ?? 1;
//                       },
//                     ),
//                   const SizedBox(height: 20),

//                   ElevatedButton(
//                     onPressed: hitungHariPasaran,
//                     child: const Text("Hitung"),
//                   ),
//                   const SizedBox(height: 20),

//                   // Output Hasil
//                   if (hasilHari.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           selectedVariant?.keterangan ?? "Hasil Selametan",
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           "$hasilHari $hasilPasaran"
//                           "${hasilTanggalAkhir != null ? ' (${TanggalUtils.format(hasilTanggalAkhir!, format: 'EEEE, dd MMMM yyyy')})' : ' ($jumlahHari Dina)'}",
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../ui/selametan_page.dart';
import '../ui/weton_page.dart';
import '../ui/bantuan_page.dart';
import '../widgets/top_nav_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePageOn(),
    HitungSelametanPage(),
    WetonPage(),
    BantuanPage(),
  ];

  void _onNavItemTapped(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator Primbon Jawa"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          TopNavMenu(
            selectedIndex: selectedIndex,
            onItemSelected: _onNavItemTapped,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _pages[selectedIndex]),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(8),
            child: const Text("Created by Akbarpeth"),
          ),
        ],
      ),
    );
  }
}

class HomePageOn extends StatelessWidget {
  const HomePageOn({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Selamat datang di aplikasi Kalkulator Primbon Jawa. Silakan pilih salah satu menu di bawah ini untuk mulai menggunakan aplikasi.",
          style: Theme.of(context).textTheme.titleLarge, // Fix headline6
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildCardMenu(
          context,
          icon: Icons.calendar_today,
          title: 'Kalkulator Selametan',
          subtitle: 'Hitung tanggal selamatan berdasarkan hari kematian.',
          destination: const HitungSelametanPage(),
        ),
        _buildCardMenu(
          context,
          icon: Icons.access_time,
          title: 'Hitung Weton',
          subtitle: 'Lihat weton berdasarkan tanggal lahir.',
          destination: const WetonPage(),
        ),
        _buildCardMenu(
          context,
          icon: Icons.help_outline,
          title: 'Bantuan Penggunaan',
          subtitle: 'Panduan dan informasi penggunaan aplikasi.',
          destination: const BantuanPage(),
        ),
      ],
    );
  }

  Widget _buildCardMenu(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: Colors.brown),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

