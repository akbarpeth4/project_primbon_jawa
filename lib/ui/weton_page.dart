import 'package:flutter/material.dart';
import '../utils/tanggal_utils.dart';
import '../widgets/tanggal_input.dart';
import '../services/hari_pasaran_calculator.dart'; // pastikan path-nya sesuai

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  DateTime? selectedDate;
  String hasilWeton = "";
  String keteranganWeton = "";

  void hitungWeton() {
    if (selectedDate == null) return;

    final hari = TanggalUtils.getNamaHari(selectedDate!);
    final pasaran = TanggalUtils.getNamaPasaran(selectedDate!);
    final fullDate = TanggalUtils.format(selectedDate!, format: 'dd MMMM yyyy');

    final kalkulator = HariPasaranCalculator(hari, pasaran);
    final jumlahWeton = kalkulator.getWetonValue(hari, pasaran);

    setState(() {
      hasilWeton = "$hari $pasaran ($fullDate)";
      keteranganWeton = "Weton ini memiliki jumlah $jumlahWeton";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cek Weton"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TanggalInput(
              selectedDate: selectedDate,
              jumlahHari: 0,
              namaHariInput: '',
              onDateSelected: (picked) => setState(() => selectedDate = picked),
              onTanggalHasilChanged: (_) {},
              enableValidation: false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hitungWeton,
              child: const Text("Cek Weton"),
            ),
            const SizedBox(height: 20),
            if (hasilWeton.isNotEmpty) ...[
              Text(
                hasilWeton,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                keteranganWeton,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
