import 'package:flutter/material.dart';
import '../services/hari_pasaran_calculator.dart';
import '../widgets/dropdown_variants.dart';
import '../widgets/tanggal_input.dart'; // pastikan file ini ada
import '../models/hari_variants.dart';
import '../utils/tanggal_utils.dart';   // untuk format tanggal

class HitungSelametanPage extends StatefulWidget {
  const HitungSelametanPage({super.key});

  @override
  State<HitungSelametanPage> createState() => _HitungSelametanPageState();
}

class _HitungSelametanPageState extends State<HitungSelametanPage> {
  String selectedHari = "Ahad";
  String selectedPasaran = "Legi";
  int jumlahHari = 1;
  bool isManual = false;

  HariVariant? selectedVariant;
  String hasilHari = "";
  String hasilPasaran = "";

  DateTime? selectedTanggalAwal;
  DateTime? hasilTanggalAkhir;

  final List<String> hariList = ["Ahad", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
  final List<String> pasaranList = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

  void hitungHariPasaran() {
    int hariYangDipakai = isManual ? jumlahHari : selectedVariant?.days ?? 1;

    final calculator = HariPasaranCalculator(selectedHari, selectedPasaran);
    final result = calculator.hitung(hariYangDipakai);

    setState(() {
      hasilHari = result.hari;
      hasilPasaran = result.pasaran;

      // Hitung tanggal akhir juga
      if (selectedTanggalAwal != null) {
        hasilTanggalAkhir = selectedTanggalAwal!.add(Duration(days: hariYangDipakai-1));
      } else {
        hasilTanggalAkhir = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Selametan Hari Kematian'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  

                  // Hari dan Pasaran Awal
                  DropdownButtonFormField<String>(
                    value: selectedHari,
                    items: hariList.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    decoration: const InputDecoration(labelText: "Hari Awal"),
                    onChanged: (value) {
                      setState(() => selectedHari = value!);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedPasaran,
                    items: pasaranList.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    decoration: const InputDecoration(labelText: "Pasaran Awal"),
                    onChanged: (value) {
                      setState(() => selectedPasaran = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  // Tanggal Awal
                  TanggalInput(
                    selectedDate: selectedTanggalAwal,
                    jumlahHari: isManual ? jumlahHari : selectedVariant?.days ?? 1,
                    namaHariInput: selectedHari,
                    onDateSelected: (picked) => setState(() => selectedTanggalAwal = picked),
                    onTanggalHasilChanged: (hasilDate) => setState(() => hasilTanggalAkhir = hasilDate),
                  ),
                  const SizedBox(height: 16),
                  // Variant Dropdown
                  VariantDropdown(
                    selected: selectedVariant,
                    onChanged: (value) {
                      setState(() {
                        selectedVariant = value;
                        isManual = value?.label == "Manual";
                        if (!isManual) jumlahHari = value?.days ?? 1;
                      });
                    },
                  ),

                  if (isManual)
                    TextFormField(
                      initialValue: jumlahHari.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Jumlah Hari (Manual)"),
                      onChanged: (value) {
                        jumlahHari = int.tryParse(value) ?? 1;
                      },
                    ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: hitungHariPasaran,
                    child: const Text("Hitung"),
                  ),
                  const SizedBox(height: 20),

                  // Output Hasil
                  if (hasilHari.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedVariant?.keterangan ?? "Hasil Selametan",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$hasilHari $hasilPasaran"
                          "${hasilTanggalAkhir != null ? ' (${TanggalUtils.format(hasilTanggalAkhir!, format: 'EEEE, dd MMMM yyyy')})' : ' ($jumlahHari Dina)'}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
