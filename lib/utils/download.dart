import 'dart:io';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:basic_navigation/database/entities/event.dart';
import 'package:csv/csv.dart';

import 'package:flutter/material.dart';

import '../database/database.dart';

class DownloadDb{
  DownloadDb({required this.db});

  final AppDatabase db;

Future<bool> requestPermission() async {
    bool storagePermission;
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 32) {
        storagePermission = await Permission.photos.isGranted;
      } else {
        storagePermission = await Permission.storage.isGranted;
      }
    } else {
      storagePermission = await Permission.storage.isGranted;
    }
    bool mediaPermission = await Permission.accessMediaLocation.isGranted;
    bool manageExternal = await Permission.manageExternalStorage.isGranted;

    if (!storagePermission) {
      if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        if (deviceInfo.version.sdkInt > 32) {
          storagePermission = await Permission.photos.request().isGranted;
        } else {
          storagePermission = await Permission.storage.request().isGranted;
        }
      } else {
        storagePermission = await Permission.storage.request().isGranted;
      }
    }

    if (!mediaPermission) {
      mediaPermission =
          await Permission.accessMediaLocation.request().isGranted;
    }

    if (!manageExternal) {
      manageExternal =
          await Permission.manageExternalStorage.request().isGranted;
    }

    bool isPermissionGranted = storagePermission && mediaPermission;

    if (isPermissionGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> downloadData() async{
    bool didSuceed = false;
    String path = '';

    bool permission = await requestPermission();

    Directory? directory = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
            : await getApplicationDocumentsDirectory())!.path}/data'); //FOR iOS

    if (await directory.exists()) {
      path = directory.path;
    } else {
      await directory.create();
      path = directory.path;
    }

   

   List<dynamic> headerPolar = ['pranzo1','pranzo2','pranzo3','pranzo4','cena1','cena2','cena3','cena4','snack','colazione','from'];
   List<List<dynamic>>  rowPolar = [];
   rowPolar.add(headerPolar);
    List<Event> eventi = await db.eventDao.findAllEvents();
    eventi.forEach((element) {rowPolar.add([element.pranzo1,element.pranzo2,element.pranzo3,element.pranzo4,element.cena1,element.cena2,element.cena3,element.cena4,element.snack,element.colazione,element.from]);});
   if(rowPolar.length > 1){
    String eventiCsv = ListToCsvConverter().convert(rowPolar);
    final fileEventi = File('$path/eventi.csv');
    fileEventi.writeAsString(eventiCsv); didSuceed = true;}

    return didSuceed;
  
  }
   
}