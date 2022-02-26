import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pancang_request/API/apiitem.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Widget> _item = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    APIItem.getRandomItem(context).then((value) {
      setState(() {
        _loading = false;
        _item = [];
      });
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
                              "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "",
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
                              "Stock",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              ":",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {},
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            : SingleChildScrollView(child: Column(children: _item)));
  }
}
