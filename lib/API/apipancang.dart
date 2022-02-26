// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class APIPancang {
  String idpancang, pancang, status, lanjut;

  APIPancang({this.idpancang, this.pancang, this.status, this.lanjut});

  factory APIPancang.hasilData(Map<String, dynamic> object) {
    return APIPancang(
      idpancang: object['IDPancang'],
      pancang: object['Pancang'],
      status: object['status'],
      lanjut: object['lanjut'],
    );
  }

  static Future<List<APIPancang>> getPancang(BuildContext context) async {
    String apiURL = "http://222.124.139.234/PancangRequest/Pancang/getPancang";

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

        List<APIPancang> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIPancang.hasilData(listData[i]));
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

  static Future<List<APIPancang>> verifikasiPerangkat(
      BuildContext context, var data) async {
    String apiURL =
        "http://222.124.139.234/PancangRequest/Pancang/verifikasiPerangkat";

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

        List<APIPancang> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIPancang.hasilData(listData[i]));
        }
        return data;
      } else {
        g.Get.snackbar("Maaf", "Gagal Login\nSilahkan Coba Ulang",
            backgroundColor: Colors.yellow);
        return null;
      }
    } catch (e) {
      g.Get.snackbar("Maaf", "Gagal Login\nSilahkan Coba Ulang",
          backgroundColor: Colors.yellow);
      return null;
    }
  }

  static Future<List<APIPancang>> logoutPancang(
      BuildContext context, String idpancang) async {
    String apiURL =
        "http://222.124.139.234/PancangRequest/Pancang/LogoutPancang/$idpancang";

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

        List<APIPancang> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIPancang.hasilData(listData[i]));
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
