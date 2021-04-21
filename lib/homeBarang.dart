import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toko_bangunan/DbHelper/dbhelper.dart';
import 'package:toko_bangunan/model/barang.dart';
import 'dart:async';
import 'entryformBarang.dart';

class HomeBarang extends StatefulWidget {
  @override
  HomeBarangState createState() => HomeBarangState();
}

class HomeBarangState extends State<HomeBarang> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Barang> barangList;

  @override
  //menampilkan data yang sudah diinputkan ketika pertama kali membuka aplikasi
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    updateListView();
    if (barangList == null) {
      barangList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data Barang'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),

        //add data barang
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Barang"),
              onPressed: () async {
                var Barang = await navigateToEntryForm(context, null);
                if (Barang != null) {
                  int result = await dbHelper.insertBarang(Barang);
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

  Future<Barang> navigateToEntryForm(
      BuildContext context, Barang barang) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(barang);
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
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.list),
            ),
            //menampilkan data yang di add di home
            title: Text(
              this.barangList[index].kode,
              style: TextStyle(),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kode Barang : " + this.barangList[index].kode,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Nama Barang : " + this.barangList[index].nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Harga Barang : " + this.barangList[index].harga,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Stok Barang : " + this.barangList[index].stok.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            //button edit data
            // widget yang ditampilkan setelah title
            trailing: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () async {
                    var barang = await navigateToEntryForm(
                        context, this.barangList[index]);
                    if (barang != null) {
                      int result = await dbHelper.updateBarang(barang);
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
                    dbHelper.deleteBarang(this.barangList[index].id);
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
      Future<List<Barang>> barangListFuture = dbHelper.getBarangList();
      barangListFuture.then((barangList) {
        setState(() {
          this.barangList = barangList;
          this.count = barangList.length;
        });
      });
    });
  }
}
