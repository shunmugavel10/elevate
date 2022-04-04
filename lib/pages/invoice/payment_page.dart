import 'package:dio/dio.dart';
import 'package:farm_direct/model/cart_model.dart';
import 'package:farm_direct/network/apiClient.dart';
import 'package:farm_direct/network/api_list.dart';
import 'package:farm_direct/pages/common/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'transaction_result.dart';


class PaymentPage extends StatefulWidget {
  final String orderId,userId;
  final CartModel cartData;
  final dynamic amount, currencyType;

  const PaymentPage({Key key, this.orderId, this.cartData, this.amount, this.currencyType, this.userId}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay =new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_LT6o7fugdJpbNd',
      'amount': 20000,
      'name': 'Farmdirect',
      "order_id": widget.orderId,
      'description': 'Your daily needs to your doorstep',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print(widget.orderId);
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("success");
    Response response;
    try {
      final _dio = apiClient();
      await _dio.then((value) async {response =await value.put("$url_get_orders",data: {
        "customerId": widget.userId,
        "type": "SALES",
        "creatorType": "CUSTOMER",
        "paymentType": "CREDIT_CARD",
        "items": widget.cartData.items,
        "orderLevelDiscount": widget.cartData.orderLevelDiscount,
        "subTotal": widget.cartData.subTotal,
        "totalTax": widget.cartData.totalTax,
        "total": widget.cartData.total,
        "billingAddress": {
          "street": "101 Nandhini Street",
          "city": "Hyderabad",
          "state": "AndhraPradesh",
          "country": "India",
          "pincode": "516003",
          "type": "HOME"
        },
        "shippingAddress": {
          "street": "101 Nandhini Street",
          "city": "Hyderabad",
          "state": "AndhraPradesh",
          "country": "India",
          "pincode": "516003",
          "type": "WORK"
        },
        "payment": {
          "paymentId": "",
          "status": "Paid",
          "method": "",
          "paymentResponse": "",
          "paidAmount": {
            "value": widget.amount,
            "currency": widget.currencyType
          }
        },
        "vendorId": "965df4d0-d44e-4cd2-b8f9-f01b6b3f0635"
      });});
        if (response.statusCode == 200) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TransactionResult(
            result: true,)), (route) => false);
        } else {
          print("err");
          showtoast("Failed_succ");
        }
    } catch (e) {
      showtoast("Failed_succ");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);

    print(widget.orderId);
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TransactionResult(
      result: false,)), (route) => false);
  }
}