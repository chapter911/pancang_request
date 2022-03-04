// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class APIItem {
  String categoryname,
      subcategoryname,
      itemid,
      olditemid,
      itemname,
      purchaseuomname,
      qnty;

  APIItem(
      {this.categoryname,
      this.subcategoryname,
      this.itemid,
      this.olditemid,
      this.itemname,
      this.purchaseuomname,
      this.qnty});

  factory APIItem.hasilData(Map<String, dynamic> object) {
    return APIItem(
        categoryname: object['CategoryName'],
        subcategoryname: object['SubCategoryName'],
        itemid: object['ItemID'],
        olditemid: object['OldItemID'],
        itemname: object['ItemName'],
        purchaseuomname: object['PurchaseUOMName'],
        qnty: object['Qnty']);
  }

  static Future<List<APIItem>> getRandomItem(BuildContext context) async {
    String apiURL = "http://222.124.139.234/PancangRequest/Item/getRandomItem";

    BaseOptions options = BaseOptions(
      baseUrl: apiURL,
      connectTimeout: 60000,
      receiveTimeout: 30000,
    );

    Dio dio = Dio(options);

    Response response = await dio.get(apiURL);

    try {
      if (response.statusCode == 200) {
        dynamic listData = response.data;

        List<APIItem> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIItem.hasilData(listData[i]));
        }
        return data;
      } else {
        g.Get.snackbar("Maaf", "Gagal Mengambil Data\nSilahkan Coba Ulang",
            backgroundColor: Colors.yellow);
        return null;
      }
    } catch (e) {
      g.Get.snackbar("Maaf", "Gagal Mengambil Data\nSilahkan Coba Ulang",
          backgroundColor: Colors.yellow);
      return null;
    }
  }

  static Future<List<APIItem>> getItemByName(
      BuildContext context, String namabarang) async {
    String apiURL =
        "http://222.124.139.234/PancangRequest/Item/getItemByName/$namabarang";

    BaseOptions options = BaseOptions(
      baseUrl: apiURL,
      connectTimeout: 60000,
      receiveTimeout: 30000,
    );

    Dio dio = Dio(options);

    Response response = await dio.get(apiURL);

    try {
      if (response.statusCode == 200) {
        dynamic listData = response.data;

        List<APIItem> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIItem.hasilData(listData[i]));
        }
        return data;
      } else {
        g.Get.snackbar("Maaf", "Gagal Mengambil Data\nSilahkan Coba Ulang",
            backgroundColor: Colors.yellow);
        return null;
      }
    } catch (e) {
      g.Get.snackbar("Maaf", "Gagal Mengambil Data\nSilahkan Coba Ulang",
          backgroundColor: Colors.yellow);
      return null;
    }
  }
}
