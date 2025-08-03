import 'package:flutter/material.dart';
import '../utils/tanggal_utils.dart';

class TanggalInput extends StatefulWidget {
  final DateTime? selectedDate;
  final int jumlahHari;
  final String namaHariInput;
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<DateTime?> onTanggalHasilChanged;
  final bool enableValidation;

  const TanggalInput({
    super.key,
    required this.selectedDate,
    required this.jumlahHari,
    required this.namaHariInput,
    required this.onDateSelected,
    required this.onTanggalHasilChanged,
    this.enableValidation = true,
  });

  @override
  State<TanggalInput> createState() => _TanggalInputState();
}

class _TanggalInputState extends State<TanggalInput> {
  DateTime? _displayedDate;

  @override
  void initState() {
    super.initState();
    _displayedDate = widget.selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );

    if (picked != null) {
      final namaHariDipilih = TanggalUtils.getNamaHari(picked);

      // Jika validasi aktif dan hari tidak cocok
      if (widget.enableValidation &&
          widget.namaHariInput.isNotEmpty &&
          namaHariDipilih != widget.namaHariInput) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'Tanggal yang Anda pilih adalah hari $namaHariDipilih, bukan ${widget.namaHariInput}!',
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
        }

        setState(() {
          _displayedDate = null; // reset tampilan tanggal
        });

        widget.onDateSelected(null);
        widget.onTanggalHasilChanged(null);
        return;
      }

      // Jika validasi lolos
      setState(() {
        _displayedDate = picked;
      });

      final tanggalHasil =
          TanggalUtils.hitungTanggalAkhir(picked, widget.jumlahHari);
      widget.onDateSelected(picked);
      widget.onTanggalHasilChanged(tanggalHasil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _displayedDate != null
                  ? "Tanggal: ${TanggalUtils.format(_displayedDate)}"
                  : "Tanggal belum dipilih",
            ),
            TextButton(
              onPressed: () => _selectDate(context),
              child: const Text("Pilih Tanggal"),
            ),
          ],
        ),
      ],
    );
  }
}
