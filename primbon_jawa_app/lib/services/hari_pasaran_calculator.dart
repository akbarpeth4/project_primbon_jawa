import '../interface/i_hari_pasaran_calculator.dart';
import 'hari_pasaran_result.dart';

class HariPasaranCalculator implements IHariPasaranCalculator {
  final String hariAwal;
  final String pasaranAwal;

  final List<String> hariList = ["Ahad", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
  final List<String> pasaranList = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

  final Map<String, int> nilaiHari = {
    "Ahad": 5,
    "Senin": 4,
    "Selasa": 3,
    "Rabu": 7,
    "Kamis": 8,
    "Jumat": 6,
    "Sabtu": 9,
  };

  final Map<String, int> nilaiPasaran = {
    "Legi": 5,
    "Pahing": 9,
    "Pon": 7,
    "Wage": 4,
    "Kliwon": 8,
  };

  late final int idxHariAwal;
  late final int idxPasaranAwal;

  HariPasaranCalculator(this.hariAwal, this.pasaranAwal) {
    idxHariAwal = hariList.indexOf(hariAwal);
    idxPasaranAwal = pasaranList.indexOf(pasaranAwal);
  }

  @override
  HariPasaranResult hitung(int jumlahHari) {
    int hariKe = (idxHariAwal + jumlahHari - 1) % hariList.length;
    int pasaranKe = (idxPasaranAwal + jumlahHari - 1) % pasaranList.length;
    return HariPasaranResult(hariList[hariKe], pasaranList[pasaranKe]);
  }

  /// Mengembalikan total nilai weton berdasarkan hari dan pasaran
  int getWetonValue(String hari, String pasaran) {
    if (nilaiHari.containsKey(hari) && nilaiPasaran.containsKey(pasaran)) {
      return nilaiHari[hari]! + nilaiPasaran[pasaran]!;
    } else {
      throw ArgumentError("Hari atau Pasaran tidak valid");
    }
  }

  /// Mengembalikan label hasil weton, misal: "Senin Pahing (13)"
  String formatWetonLabel(String hari, String pasaran) {
    int weton = getWetonValue(hari, pasaran);
    return "$hari $pasaran ($weton)";
  }
}
