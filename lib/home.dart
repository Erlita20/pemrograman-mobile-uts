import 'package:flutter/material.dart';
import 'package:toko_bangunan/homeBarang.dart';
import 'package:toko_bangunan/homePelanggan.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Bangunan'),
        leading: new Icon(Icons.home, size: 30.0, color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, top: 15, right: 15),
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //menambahkan gambar logo
            Image.asset('assets/images/logotb.jpg'),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeBarang(),
                            ));
                      },
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 15),
                      child: Column(
                        //untuk menempatkan icon & teks pada raised button secara vertikal
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // membuat box
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  100), //membuat border radius
                            ),
                            child: Icon(
                              //icon barang
                              Icons.store_mall_directory,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Data Barang",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePelanggan(),
                            ));
                      },
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: Column(
                        //untuk menempatkan icon dan teks di setiap raised button
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  100), //membuat border radius
                            ),
                            child: Icon(
                              //icon pelanggan
                              Icons.people_outline,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Data Pelanggan",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
