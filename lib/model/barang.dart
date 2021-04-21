class Barang {
  int _id;
  String _kode;
  String _nama;
  int _harga;
  int _stok;

  //getter dan setter
  int get id => _id;

  get kode => this._kode;
  set kode(value) => this._kode = value;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  get harga => this._harga;
  set harga(value) => this._harga = value;

  int get stok => this._stok;
  set stok(int value) => this._stok = value;

  //konstruktor
  Barang(this._kode, this._nama, this._harga, this._stok);

  //konversi dari Map ke Barang
  Barang.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _kode = map['kode'];
    _nama = map['nama'];
    _harga = map['harga'];
    _stok = map['stok'];
  }

  //konversi dari Barang ke map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this._id;
    map['kode'] = this.kode;
    map['nama'] = this.nama;
    map['harga'] = this.harga;
    map['stok'] = this.stok;
    return map;
  }
}
