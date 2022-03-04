import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController _namabarang = TextEditingController();
  TextEditingController _jumlah = TextEditingController();
  TextEditingController _keterangan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Barang"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _namabarang,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.category),
                labelText: "Nama Barang",
                prefixStyle: const TextStyle(
                    color: Color(0xFF000080), fontWeight: FontWeight.w600),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _jumlah,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.summarize_outlined),
                labelText: "Jumlah",
                prefixStyle: const TextStyle(
                    color: Color(0xFF000080), fontWeight: FontWeight.w600),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _keterangan,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.note_alt),
                labelText: "Keterangan",
                prefixStyle: const TextStyle(
                    color: Color(0xFF000080), fontWeight: FontWeight.w600),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[900]),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_namabarang.text == "" || _jumlah.text == "") {
            Get.snackbar("Maaf", "Harap Lengkapi Data Anda",
                backgroundColor: Colors.yellow);
          } else if (_keterangan.text.length < 10) {
            Get.snackbar("Maaf", "Minimal Keterangan 10 Karakter",
                backgroundColor: Colors.yellow);
          } else {
            Get.snackbar("ASDDASD", "HJKAGSJH");
          }
        },
      ),
    );
  }
}
