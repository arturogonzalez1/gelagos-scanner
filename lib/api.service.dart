import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiService {
  Future<Map> getCoupon(String secret_id) async {
    http.Response response =
    await http.get('http://201.160.67.243:5000/api/v1/coupons/$secret_id');
    var data = jsonDecode(response.body);
    return data[0];
  }
}
