class Pelanggan {
  int _id;
  String _nama;
  String _alamat;
  int _telepon;

  //getter dan setter
  int get id => _id;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  String get alamat => this._alamat;
  set alamat(String value) => this._alamat = value;

  get telepon => this._telepon;
  set telepon(value) => this._telepon = value;

  //konstruktor
  Pelanggan(this._nama, this._alamat, this._telepon);

  //konversi dari Map ke Pelanggan
  Pelanggan.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _nama = map['nama'];
    _alamat = map['alamat'];
    _telepon = map['telepon'];
  }

  //konversi dari Pelanggan ke map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = this.nama;
    map['alamat'] = this.alamat;
    map['telepon'] = this.telepon;
    return map;
  }
}
