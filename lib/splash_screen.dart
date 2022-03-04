import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pancang_request/API/apipancang.dart';
import 'package:pancang_request/Model/datasharedpreferences.dart';
import 'package:pancang_request/homepage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final TextEditingController _password = TextEditingController();
  final RoundedLoadingButtonController _login =
      RoundedLoadingButtonController();

  bool login = false;

  final List<String> _pancangid = ["0"], _pancangname = ["- PILIH -"];
  String _pilihanid = "0",
      _pilihanpancang = "- PILIH -",
      _serialdevice = "",
      _device = "",
      _model = "",
      _appversion = "",
      _os = "",
      _osversion = "";

  @override
  void initState() {
    super.initState();
    checkUser();
    initPlatformState();
    APIPancang.getPancang(context).then((value) {
      for (var i = 0; i < value.length; i++) {
        _pancangid.add(value[i].idpancang);
        _pancangname.add(value[i].pancang);
      }
      setState(() {});
    });
  }

  Future<bool> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("serialdevice")) {
      DataSharedPreferences().readString("serialdevice").then((serialDevice) {
        APIPancang.cekSerialDevice(context, serialDevice).then((value) {
          Get.snackbar("Informasi", value[0].lanjut,
              backgroundColor: Colors.yellow);
          if (value[0].status == "success") {
            Get.to(() => const HomePage(),
                duration: const Duration(seconds: 2));
          } else {
            DataSharedPreferences().clearData();
            Get.offAll(() => const SplashScreen());
          }
        });
      });
    } else {
      setState(() {
        login = true;
      });
    }
    return true;
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        _device = deviceData['brand'];
        _model = deviceData['model'];
        _serialdevice = deviceData['androidId'];
        _osversion = deviceData['version.sdkInt'].toString();
        _os = deviceData['version.release'];
        getAppVersion();
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        _device = "IPhone";
        _model = deviceData['model'];
        _serialdevice = deviceData['identifierForVendor'];
        _osversion = deviceData['systemVersion'];
        _os = deviceData['systemVersion'];
        getAppVersion();
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {});
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'brand': build.brand,
      'model': build.model,
      'androidId': build.androidId
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'model': data.model,
      'systemVersion': data.systemVersion,
      'identifierForVendor': data.identifierForVendor
    };
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/app_logo.png',
              scale: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pancang Request",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "v. $_appversion",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 50,
            ),
            Visibility(
              visible: login,
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: 'Pancang',
                          icon: Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Icon(Icons.apartment))),
                      isExpanded: true,
                      items: _pancangname.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _pilihanpancang = value;
                          _pilihanid = _pancangid[_pancangname.indexOf(value)];
                        });
                      },
                      value: _pilihanpancang,
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.vpn_key),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedLoadingButton(
                      controller: _login,
                      onPressed: () {
                        if (_pilihanid == "0" || _password.text == "") {
                          _login.reset();
                          Get.snackbar("Maaf", "Harap Lengkapi Data Anda",
                              backgroundColor: Colors.yellow);
                        } else {
                          setState(() {
                            APIPancang.verifikasiPerangkat(context, {
                              "SerialDevice": _serialdevice,
                              "PancangID": _pilihanid,
                              "Pancang": _pilihanpancang,
                              "Device": _device,
                              "Model": _model,
                              "AppVersion": _appversion,
                              "OS": _os,
                              "OSVersion": _osversion,
                              "Password": _password.text
                            }).then((value) {
                              _login.reset();
                              if (value[0].lanjut == "1") {
                                DataSharedPreferences()
                                    .saveString("serialdevice", _serialdevice);
                                DataSharedPreferences()
                                    .saveString("idpancang", _pilihanid);
                                DataSharedPreferences()
                                    .saveString("pancangname", _pilihanpancang);
                                Get.offAll(() => const HomePage());
                              }
                              Get.snackbar("Informasi", value[0].status,
                                  backgroundColor: Colors.yellow);
                            });
                          });
                        }
                      },
                      child: const Text("MASUK"),
                      color: Colors.blue[900],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
