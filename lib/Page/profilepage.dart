import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pancang_request/API/apipancang.dart';
import 'package:pancang_request/Model/datasharedpreferences.dart';
import 'package:pancang_request/splash_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final RoundedLoadingButtonController _logout =
      RoundedLoadingButtonController();
  String _appversion = "", _pancangname = "", _idpancang = "";

  @override
  void initState() {
    super.initState();
    getAppVersion();
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
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/cashier.png',
              scale: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _pancangname,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "v. $_appversion",
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: RoundedLoadingButton(
                controller: _logout,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => WillPopScope(
                      onWillPop: () {
                        setState(() {
                          _logout.reset();
                        });
                        Get.back();
                        return;
                      },
                      child: AlertDialog(
                        titlePadding: const EdgeInsets.all(0),
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.red[900],
                          child: const Text(
                            "Apakah Anda Ingin Logout Dari Aplikasi?",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _logout.reset();
                              });
                              Get.back();
                            },
                            child: const Text("Batal"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900]),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              APIPancang.logoutPancang(context, _idpancang)
                                  .then((value) {
                                setState(() {
                                  _logout.reset();
                                });
                                Get.snackbar("Informasi", value[0].status,
                                    backgroundColor: Colors.yellow);
                                if (value[0].lanjut == "1") {
                                  DataSharedPreferences().clearData();
                                  Get.offAll(const SplashScreen());
                                }
                              });
                            },
                            child: const Text("Ya"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[900]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text("LOGOUT"),
                color: Colors.red[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
