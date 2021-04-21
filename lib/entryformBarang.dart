import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toko_bangunan/DBHelper/dbhelper.dart';
import 'package:toko_bangunan/model/barang.dart';
import 'package:toko_bangunan/model/pelanggan.dart';

class EntryForm extends StatefulWidget {
  final Barang barang;
  EntryForm(this.barang);
  @override
  EntryFormState createState() => EntryFormState(this.barang);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Barang barang;
  Pelanggan pelanggan;
  DbHelper dbHelper = DbHelper();
  EntryFormState(this.barang);

  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  List<Pelanggan> pelangganList = List<Pelanggan>();
  List<String> listPelanggan = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Pelanggan>> PelangganListFuture = dbHelper.getPelangganList();
      PelangganListFuture.then((PelangganList) {
        setState(() {
          for (int i = 0; i < PelangganList.length; i++) {
            listPelanggan.add(PelangganList[i].nama);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (barang != null) {
      kodeController.text = barang.kode;
      namaController.text = barang.nama;
      hargaController.text = barang.harga;
      stokController.text = barang.stok.toString();
    }
    //edit
    return Scaffold(
        appBar: AppBar(
          title: barang == null ? Text('Tambah') : Text('Edit'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // kode barang
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kodeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kode Barang',
                    icon: Icon(Icons.list),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // nama barang
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    icon: Icon(Icons.notes_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga Barang',
                    icon: Icon(Icons.account_balance_wallet),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              // stok
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stok Barang',
                    icon: Icon(Icons.shopping_cart),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    //tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (barang == null) {
                            // tambah data barang
                            barang = Barang(
                                kodeController
                                    .text, //tambah atribut pada atribut kode
                                namaController
                                    .text, //tambah atribut pada atribut nama
                                int.parse(hargaController
                                    .text), //tambah atribut pada atribut harga
                                int.parse(stokController
                                    .text)); //tambah atribut pada atribut stok
                          } else {
                            // ubah data barang
                            barang.kode = kodeController
                                .text; //ubah atribut pada atribut kode
                            barang.nama = namaController
                                .text; //ubah atribut pada atribut nama
                            barang.harga = int.parse(hargaController
                                .text); //ubah atribut pada atribut harga
                            barang.stok = int.parse(stokController
                                .text); //ubah atribut pada atribut stok
                          }
                          // kembali ke layar sebelumnya dengan membawa objek barang
                          Navigator.pop(context, barang);
                        },
                      ),
                    ),
                    Container(
                      width: 30, // memberi jarak antara bottom save dan cancel
                    ),

                    // tombol batal
                    Expanded(
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
