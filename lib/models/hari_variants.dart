class HariVariant {
  final String label;
  final int days;
  final String keterangan;

  const HariVariant(this.label, this.days, this.keterangan);
}

const List<HariVariant> hariVariants = [
  HariVariant("Geblak (1 hari)", 1, "Selamatan prosesi penguburan hari pertama"),
  HariVariant("3 Dina / Nelung Dina", 3, "Selamatan tiga hari kematian"),
  HariVariant("7 Dina / Mitung Dina", 7, "Selamatan tujuh hari kematian"),
  HariVariant("40 Dina / Matangpuluh Dina", 40, "Selamatan ke-40 hari kematian"),
  HariVariant("100 Dina / Nyetatus Dina", 100, "Selamatan seratus hari kematian"),
  HariVariant("Pendhak 1 (1 tahun = 354 hari)", 354, "Selamatan setahun setelah kematian"),
  HariVariant("Pendhak 2 (2 tahun = 708 hari)", 708, "Selamatan dua tahun setelah kematian"),
  HariVariant("Nyewu (1000 hari)", 1000, "Selamatan ke-1000 hari kematian"),
  HariVariant("Manual", 0, "Pasaran yang dipilih sesuai jumlah hari"),
];
