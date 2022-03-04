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
      qnty,
      status,
      lanjut;

  APIItem(
      {this.categoryname,
      this.subcategoryname,
      this.itemid,
      this.olditemid,
      this.itemname,
      this.purchaseuomname,
      this.qnty,
      this.status,
      this.lanjut});

  factory APIItem.hasilData(Map<String, dynamic> object) {
    return APIItem(
        categoryname: object['CategoryName'],
        subcategoryname: object['SubCategoryName'],
        itemid: object['ItemID'],
        olditemid: object['OldItemID'],
        itemname: object['ItemName'],
        purchaseuomname: object['PurchaseUOMName'],
        qnty: object['Qnty'],
        status: object['status'],
        lanjut: object['lanjut']);
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

  static Future<List<APIItem>> insertRequest(
      BuildContext context, var data) async {
    String apiURL = "http://222.124.139.234/PancangRequest/Item/insertRequest";

    BaseOptions options = BaseOptions(
      baseUrl: apiURL,
      connectTimeout: 60000,
      receiveTimeout: 30000,
    );

    Dio dio = Dio(options);

    Response response = await dio.post(apiURL, data: data);

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

  static Future<List<APIItem>> insertNewRequest(
      BuildContext context, var data) async {
    String apiURL =
        "http://222.124.139.234/PancangRequest/Item/insertNewRequest";

    BaseOptions options = BaseOptions(
      baseUrl: apiURL,
      connectTimeout: 60000,
      receiveTimeout: 30000,
    );

    Dio dio = Dio(options);

    Response response = await dio.post(apiURL, data: data);

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
