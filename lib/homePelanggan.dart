import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toko_bangunan/DbHelper/dbhelper.dart';
import 'package:toko_bangunan/model/pelanggan.dart';
import 'dart:async';
import 'package:toko_bangunan/entryformPelanggan.dart';

class HomePelanggan extends StatefulWidget {
  @override
  HomePelangganState createState() => HomePelangganState();
}

class HomePelangganState extends State<HomePelanggan> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Pelanggan> pelangganList;

  @override
  //menampilkan data yang sudah diinputkan ketika pertama kali membuka aplikasi
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (pelangganList == null) {
      pelangganList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data Pelanggan'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        //add data pelanggan
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Pelanggan"),
              onPressed: () async {
                var Pelanggan = await navigateToEntryForm(context, null);
                if (Pelanggan != null) {
                  int result = await dbHelper.insertPelanggan(Pelanggan);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Pelanggan> navigateToEntryForm(
      BuildContext context, Pelanggan pelanggan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(pelanggan);
    }));
    return result;
  }

  ListView createListView() {
    // ignore: unused_local_variable
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blue,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.add),
            ),
            //menampilkan data yang di add di home
            title: Text(
              this.pelangganList[index].nama.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Pelanggan : " + this.pelangganList[index].nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Alamat : " + this.pelangganList[index].alamat,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Nomor Telepon : " + this.pelangganList[index].telepon,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            //button edit data
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () async {
                    var Pelanggan = await navigateToEntryForm(
                        context, this.pelangganList[index]);
                    if (Pelanggan != null) {
                      int result = await dbHelper.updatePelanggan(Pelanggan);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),
                //button hapus data
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    dbHelper.deletePelanggan(this.pelangganList[index].id);
                    updateListView();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

//update List
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Pelanggan>> barangListFuture = dbHelper.getPelangganList();
      barangListFuture.then((barangList) {
        setState(() {
          this.pelangganList = pelangganList;
          this.count = pelangganList.length;
        });
      });
    });
  }
}
