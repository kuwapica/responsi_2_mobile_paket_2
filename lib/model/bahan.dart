class Bahan {
  String? id;
  String? namaBahan;
  var hargaBahan;
  var jumlahBahan;
  String? tanggalMasuk;
  String? tanggalKedaluwarsa;

  Bahan({
    this.id,
    this.namaBahan,
    this.hargaBahan,
    this.jumlahBahan,
    this.tanggalMasuk,
    this.tanggalKedaluwarsa,
  });

  factory Bahan.fromJson(Map<String, dynamic> obj) {
    return Bahan(
      id: obj['id'],
      namaBahan: obj['nama'],
      hargaBahan: obj['harga'],
      jumlahBahan: obj['jumlah'],
      tanggalMasuk: obj['tanggal_masuk'],
      tanggalKedaluwarsa: obj['tanggal_kedaluwarsa'],
    );
  }
}
