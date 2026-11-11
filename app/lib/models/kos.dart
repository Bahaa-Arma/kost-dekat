class Kos {
  final String id;
  final String nama;
  final String area;
  final String tipe;
  final int hargaBulanan;
  final bool kamarMandiDalam;
  final double jarakKm;
  final DateTime diperbarui;

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

  factory Kos.fromJson(Map<String, dynamic> json) => Kos(
    id: json['id'] as String,
    nama: json['nama'] as String,
    area: json['area'] as String,
    tipe: json['tipe'] as String,
    hargaBulanan: (json['hargaBulanan'] as num).toInt(),
    kamarMandiDalam: json['kamarMandiDalam'] as bool,
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
