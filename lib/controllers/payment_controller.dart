import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentController {
  static const String stripeSecretKey =
      "sk_test_51NLgXbIvUVFaiCUn6y61zHV16iTghOlCdebcS6Gq7oyjikt6qpEUDC483IGjLdOJMGjK9F6al9lzaqkZASX4j6dX00wlHuv43c";
  Future<void> createTransferToTestAccount(String hostAccountId, int amountInCents) async {
    try {
      final String baseUrl = 'https://api.stripe.com/v1/transfers';

      var headers = <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $stripeSecretKey',
      };

      var body = {
        "amount": amountInCents.toString(),
        "currency": "usd",
        "destination": hostAccountId,
        "transfer_group": "ORDER_95",
      };

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("Transfer created successfully!");
        var responseData = jsonDecode(response.body);
        print("Transfer ID: ${responseData['id']}");
        // Handle successful transfer (update UI, show success message)
      } else {
        var errorResponse = jsonDecode(response.body);
        print("Failed to create transfer: ${errorResponse['error']['message']}");
        throw Exception("Failed to create transfer");
      }
    } catch (e) {
      print("Error creating transfer: $e");
      throw Exception("Error creating transfer");
    }
  }
}
