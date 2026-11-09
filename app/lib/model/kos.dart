/// Satu kos dari server. Nama field sama persis dengan `server/data/kos.json`.
class Kos {
  const Kos({
    required this.id,
    required this.nama,
    required this.area,
    required this.tipe,
    required this.hargaBulanan,
    required this.kamarMandiDalam,
    required this.jarakKm,
    required this.diperbarui,
  });

  final String id;
  final String nama;
  final String area;

  /// "Putra", "Putri", atau "Campur".
  final String tipe;
  final int hargaBulanan;
  final bool kamarMandiDalam;
  final double jarakKm;
  final DateTime diperbarui;

  factory Kos.fromJson(Map<String, dynamic> json) => Kos(
    id: json['id'] as String,
    nama: json['nama'] as String,
    area: json['area'] as String,
    tipe: json['tipe'] as String,
    hargaBulanan: json['hargaBulanan'] as int,
    kamarMandiDalam: json['kamarMandiDalam'] as bool,
    // JSON bisa mengirim 1 alih-alih 1.0.
    jarakKm: (json['jarakKm'] as num).toDouble(),
    diperbarui: DateTime.parse(json['diperbarui'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'area': area,
    'tipe': tipe,
    'hargaBulanan': hargaBulanan,
    'kamarMandiDalam': kamarMandiDalam,
    'jarakKm': jarakKm,
    'diperbarui': diperbarui.toIso8601String(),
  };
}
