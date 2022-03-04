import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pancang_request/API/apiitem.dart';
import 'package:pancang_request/Model/datasharedpreferences.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController _namabarang = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final TextEditingController _keterangan = TextEditingController();
  String _pancangname = "", _idpancang = "", _appversion = "";

  @override
  void initState() {
    super.initState();
    DataSharedPreferences().readString("pancangname").then((value) {
      setState(() {
        _pancangname = value;
      });
    });
    DataSharedPreferences().readString("idpancang").then((value) {
      setState(() {
        _idpancang = value;
      });
    });
    getAppVersion();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appversion = packageInfo.version;
    });
  }

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
        child: const Icon(Icons.send),
        backgroundColor: Colors.blue[900],
        onPressed: () {
          if (_namabarang.text == "" || _jumlah.text == "") {
            Get.snackbar("Maaf", "Harap Lengkapi Data Anda",
                backgroundColor: Colors.yellow);
          } else if (_keterangan.text.length < 10) {
            Get.snackbar("Maaf", "Minimal Keterangan 10 Karakter",
                backgroundColor: Colors.yellow);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                title: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue[900],
                  child: const Text(
                    "Anda Yakin untuk Memesan Barang Ini?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                content: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(6),
                  },
                  border: const TableBorder(
                      horizontalInside: BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid)),
                  children: [
                    TableRow(
                      children: [
                        const Text(
                          "Nama Barang",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _namabarang.text,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text(
                          "Jumlah",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _jumlah.text,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text(
                          "Keterangan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            _keterangan.text,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("BATAL"),
                    style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar("Informasi", "Mohon Tunggu",
                          backgroundColor: Colors.yellow);
                      APIItem.insertNewRequest(context, {
                        "PCGID": _idpancang,
                        "Qnty": _jumlah.text,
                        "ItemNameByPCG": _namabarang.text,
                        "PCGRemark": _keterangan.text,
                        "CreatedBy": _idpancang,
                        "CreatedByName": _pancangname,
                        "CreatedByPosition": _idpancang,
                        "CreatedByAppVersion": _appversion
                      }).then((value) {
                        if (value[0].status == "success") {
                          Get.snackbar("Informasi", "Item Berhasil DiInput",
                              backgroundColor: Colors.green[900],
                              colorText: Colors.white);
                          setState(() {
                            _namabarang.text = "";
                            _jumlah.text = "";
                            _keterangan.text = "";
                          });
                        } else {
                          Get.snackbar("Informasi", "Item Gagal DiInput",
                              backgroundColor: Colors.red[900],
                              colorText: Colors.white);
                        }
                      });
                    },
                    child: const Text("PESAN"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
