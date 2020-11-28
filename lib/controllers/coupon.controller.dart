import '../models/coupon.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CouponController {


  Future<Coupon> findById(String secretId) async {
    final response = await http.get(Coupon().getUrl('coupons/${secretId}'));
    return Coupon.fromJson(jsonDecode(response.body)[0]);
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Coupon.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to get the coupon');
    // }
  }
}