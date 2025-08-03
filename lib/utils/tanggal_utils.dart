import 'package:intl/intl.dart';

class TanggalUtils {
  /// Menghitung tanggal akhir dari tanggal awal + jumlahHari
  static DateTime? hitungTanggalAkhir(DateTime? awal, int jumlahHari) {
    if (awal == null) return null;
    return awal.add(Duration(days: jumlahHari));
  }

  /// Format tanggal sesuai pola (default: dd/MM/yyyy)
  static String format(DateTime? date, {String format = 'dd/MM/yyyy'}) {
    if (date == null) return "-";
    return DateFormat(format).format(date);
  }

  /// Mendapatkan nama hari dari DateTime (versi Jawa/Indonesia)
  static String getNamaHari(DateTime date) {
    const hari = [
      'Ahad',   // Sunday
      'Senin',  // Monday
      'Selasa', // Tuesday
      'Rabu',   // Wednesday
      'Kamis',  // Thursday
      'Jumat',  // Friday
      'Sabtu',  // Saturday
    ];
    return hari[date.weekday % 7];
  }

  /// Mendapatkan nama pasaran Jawa dari DateTime
  static String getNamaPasaran(DateTime date) {
    const pasaran = [ 'Pahing', 'Pon', 'Wage', 'Kliwon','Legi'];

    // Tanggal acuan: 1 Jan 1900 = Senin Legi
    final acuan = DateTime(1900, 1, 1);
    final selisihHari = date.difference(acuan).inDays;
    final index = selisihHari % 5;

    return pasaran[index < 0 ? (index + 5) : index];
  }

  /// Menggabungkan nama hari dan pasaran, misalnya "Senin Kliwon"
  static String formatHariPasaran(DateTime? date) {
    if (date == null) return "-";
    return "${getNamaHari(date)} ${getNamaPasaran(date)}";
  }
}
