// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class APIHistory {
  String id,
      pcgid,
      itemid,
      olditemid,
      itemname,
      purchaseuomname,
      qnty,
      pcgremark,
      newrequest,
      createdby,
      createdbyname,
      createdbyposition,
      createdbyappversion,
      createddate,
      indprocess,
      processbpbremark,
      processbpgremark,
      processppbremark;

  APIHistory(
      {this.id,
      this.pcgid,
      this.itemid,
      this.olditemid,
      this.itemname,
      this.purchaseuomname,
      this.qnty,
      this.pcgremark,
      this.newrequest,
      this.createdby,
      this.createdbyname,
      this.createdbyposition,
      this.createdbyappversion,
      this.createddate,
      this.indprocess,
      this.processbpbremark,
      this.processbpgremark,
      this.processppbremark});

  factory APIHistory.hasilData(Map<String, dynamic> object) {
    return APIHistory(
        id: object['ID'],
        pcgid: object['PCGID'],
        itemid: object['ItemID'],
        olditemid: object['OldItemID'],
        itemname: object['ItemName'],
        purchaseuomname: object['PurchaseUOMName'],
        qnty: object['Qnty'],
        pcgremark: object['PCGRemark'],
        newrequest: object['NewRequest'],
        createdby: object['CreatedBy'],
        createdbyname: object['CreatedByName'],
        createdbyposition: object['CreatedByPosition'],
        createdbyappversion: object['CreatedByAppVersion'],
        createddate: object['CreatedDate'],
        indprocess: object['IndProcess'],
        processbpbremark: object['ProcessBPBRemark'],
        processbpgremark: object['ProcessBPGRemark'],
        processppbremark: object['ProcessPPBRemark']);
  }

  static Future<List<APIHistory>> getAllRequestByPancang(
      BuildContext context, String idpancang, String tanggal) async {
    String apiURL =
        "http://222.124.139.234/PancangRequest/Item/getAllRequestByPancang/$idpancang/$tanggal";

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

        List<APIHistory> data = [];
        for (int i = 0; i < listData.length; i++) {
          data.add(APIHistory.hasilData(listData[i]));
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
