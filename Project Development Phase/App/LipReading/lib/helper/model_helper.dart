import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelHelper {
  static Future<String> getSubtitle(File file) async {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var res = http.MultipartRequest(
      "POST",
      Uri.parse("https://lipreadingapi-bftkgqe4sa-el.a.run.app/predict"),
    );
    res.headers.addAll(header);
    var videoFile = http.MultipartFile.fromBytes(
        "file", File(file.path).readAsBytesSync(),
        filename: file.path);
    res.files.add(videoFile);

    var response = await res.send();
    if (response.statusCode == 200) {
      var ans = await response.stream.bytesToString();
      debugPrint(jsonDecode(ans)["prediction"]);
      return jsonDecode(ans)["prediction"];
    } else {
      return "Error Fetching Data";
    }
  }
}
