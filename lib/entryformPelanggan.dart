import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toko_bangunan/DBHelper/dbhelper.dart';
import 'package:toko_bangunan/model/barang.dart';
import 'package:toko_bangunan/model/pelanggan.dart';

class EntryForm extends StatefulWidget {
  final Pelanggan pelanggan;

  EntryForm(this.pelanggan);

  @override
  EntryFormState createState() => EntryFormState(this.pelanggan);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Pelanggan
      pelanggan; //mendeklarasikan model pelangan yang akan digunakan diclass entryformpelanggan

  EntryFormState(this.pelanggan);
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (pelanggan != null) {
      namaController.text = pelanggan.nama;
      alamatController.text = pelanggan.alamat;
      teleponController.text = pelanggan.telepon;
    }
    //edit
    return Scaffold(
        appBar: AppBar(
          title: pelanggan == null ? Text('Tambah') : Text('Edit'),
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
              // nama pelanggan
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Pelanggan',
                    icon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // nama pelanggan
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: alamatController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Alamat Pelanggan',
                    icon: Icon(Icons.home),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // telepon
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: teleponController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    icon: Icon(Icons.contact_phone),
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
                          if (Pelanggan == null) {
                            // tambah data pelanggan
                            pelanggan = Pelanggan(
                                namaController
                                    .text, //tambah atribut pada atribut nama
                                alamatController
                                    .text, //tambah atribut pada atribut alamat
                                int.parse(teleponController
                                    .text) //tambah atribut pada atribut telepon
                                );
                          } else {
                            // ubah data pelanggan
                            pelanggan.nama = namaController
                                .text; //ubah atribut pada atribut nama
                            pelanggan.alamat = alamatController
                                .text; //ubah atribut pada atribut alamat
                            pelanggan.telepon = int.parse(teleponController
                                .text); //ubah atribut pada atribut telepon
                          }
                          // kembali ke layar sebelumnya dengan membawa objek pelanggan
                          Navigator.pop(context, Pelanggan);
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
