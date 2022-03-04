import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pancang_request/API/apihistory.dart';
import 'package:pancang_request/Model/datasharedpreferences.dart';
import 'package:pancang_request/Model/format_changer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Widget> _history = [];
  String _tanggal = "";
  String _idpancang = "";

  @override
  void initState() {
    super.initState();
    _tanggal = FormatChanger().tanggalIndo(DateTime.now());
    DataSharedPreferences().readString("idpancang").then((value) {
      setState(() {
        _idpancang = value;
      });
      getHistory();
    });
  }

  void getHistory() {
    APIHistory.getAllRequestByPancang(
            context, _idpancang, FormatChanger().tanggalAPIString(_tanggal))
        .then((value) {
      if (value[0].id == null) {
        setState(() {
          _history = [];
        });
        Get.snackbar("Maaf", "Tidak Ada History DiTanggal Ini",
            backgroundColor: Colors.yellow);
      } else {
        setState(() {
          _history = [];
        });
        for (int i = 0; i < value.length; i++) {
          _history.add(Column(
            children: [
              Container(
                width: double.maxFinite,
                color: Colors.blue,
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    "ID : " + value[i].id,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.blue[100],
                padding: const EdgeInsets.all(10),
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
                            value[i].itemname,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text(
                          "DiPesan Sebanyak",
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
                          "Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            value[i].processbpbremark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ));
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      _tanggal = FormatChanger().tanggalIndo(value);
                    });
                    getHistory();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    _tanggal,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _history,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
