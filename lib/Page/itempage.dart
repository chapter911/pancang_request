import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pancang_request/API/apiitem.dart';
import 'package:pancang_request/Model/datasharedpreferences.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final TextEditingController _pencarian = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  String _judul = "Pancang Request",
      _pancangname = "",
      _idpancang = "",
      _appversion = "";
  List<Widget> _item = [];
  bool _loading = true;

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
    getRandomItem();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appversion = packageInfo.version;
    });
  }

  void getRandomItem() {
    setState(() {
      _loading = true;
      _judul = "Pancang Request";
      _pencarian.text = "";
    });
    APIItem.getRandomItem(context).then((value) {
      setState(() {
        _loading = false;
        _item = [];
      });
      setItem(value);
    });
  }

  void getItemByName(String _name) {
    setState(() {
      _loading = true;
      _judul = "Cari : $_name";
    });
    APIItem.getItemByName(context, _name).then((value) {
      setState(() {
        _loading = false;
        _item = [];
      });
      setItem(value);
    });
  }

  void setItem(var value) {
    for (var i = 0; i < value.length; i++) {
      _item.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {},
          child: Card(
            color: Colors.blue[100],
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      value[i].itemname,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Table(
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
                            "Satuan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              value[i].purchaseuomname,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            "Kategori",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              value[i].categoryname,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            "Sub Kategori",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              value[i].subcategoryname,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            "Stock",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              value[i].qnty,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _jumlah.text = "";
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                value[i].itemname,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Text(
                                              "Kategori",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                value[i].categoryname,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Text(
                                              "Sub Kategori",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                value[i].subcategoryname,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Text(
                                              "Stock",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                value[i].qnty,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Text(
                                              "Jumlah Pesanan",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextField(
                                              controller: _jumlah,
                                              textAlign: TextAlign.end,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            )
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
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red[900]),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_jumlah.text == "" ||
                                              int.parse(_jumlah.text) == 0) {
                                            Get.snackbar("Maaf",
                                                "Harap Pastikan Jumlah Pesanan Anda",
                                                backgroundColor: Colors.yellow);
                                          } else if (int.parse(_jumlah.text) >
                                              int.parse(value[i].qnty)) {
                                            Get.snackbar("Maaf",
                                                "Jumlah Pesanan Melebihi Stock",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                          } else {
                                            Get.back();
                                            Get.snackbar(
                                                "Informasi", "Mohon Tunggu",
                                                backgroundColor: Colors.yellow);
                                            APIItem.insertRequest(context, {
                                              "PCGID": _idpancang,
                                              "ItemID": value[i].itemid,
                                              "OldItemID": value[i].olditemid,
                                              "ItemName": value[i].itemname,
                                              "PurchaseUOMName":
                                                  value[i].purchaseuomname,
                                              "Qnty": _jumlah.text,
                                              "CreatedBy": _idpancang,
                                              "CreatedByName": _pancangname,
                                              "CreatedByPosition": _idpancang,
                                              "CreatedByAppVersion": _appversion
                                            }).then((value) {
                                              if (value[0].status ==
                                                  "success") {
                                                Get.snackbar("Informasi",
                                                    "Item Berhasil DiInput",
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    colorText: Colors.white);
                                                ;
                                              } else {
                                                Get.snackbar("Informasi",
                                                    "Item Gagal DiInput",
                                                    backgroundColor:
                                                        Colors.red[900],
                                                    colorText: Colors.white);
                                              }
                                            });
                                          }
                                        },
                                        child: const Text("PESAN"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue[900]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.shopping_cart_rounded,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[900]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              getRandomItem();
            },
            icon: const Icon(Icons.restart_alt_outlined),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  titlePadding: const EdgeInsets.all(0),
                  title: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue[900],
                    child: const Text(
                      "Masukkan Nama Barang",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _pencarian,
                        decoration: const InputDecoration(
                          labelText: 'Kata Kunci',
                          icon: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (_pencarian.text == "") {
                          Get.snackbar(
                              "Perhatian!", "Mohon Input Kata Kunci Pencarian",
                              backgroundColor: Colors.yellow);
                        } else {
                          Get.back();
                          Get.snackbar("Informasi", "Mohon Tunggu...",
                              backgroundColor: Colors.yellow);
                          setState(() {
                            _loading = true;
                            _item = [];
                          });
                          getItemByName(_pencarian.text);
                        }
                      },
                      child: const Text("CARI"),
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: _loading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Mengambil List Barang...")
                    ],
                  ),
                )
              : SingleChildScrollView(child: Column(children: _item))),
    );
  }
}
