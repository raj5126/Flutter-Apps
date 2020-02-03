import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MaterialApp(
  home:Payment(),
));

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int totalAmount = 0;
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay =  Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,_handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,_handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,_handleExternalwallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

void opencheckout() async {
  var options={
    'key':'rzp_test_PudBIaiu4s6XQD',
    'amount':totalAmount*100,
    'name':'RPSolutions',
    'description':'TEST OF PAYMENT',
    'prefill':{'contact' : '','email' :''},
    'external':{
      'wallets':['paytm']
    }
  };
  try{
    _razorpay.open(options);
  }
  catch(e){
    debugPrint(e);
  }
}

void _handlePaymentSuccess(PaymentSuccessResponse response){
  Fluttertoast.showToast(msg : 'Payment Success : ' + response.paymentId);
}

void _handlePaymentError(PaymentFailureResponse response){
  Fluttertoast.showToast(msg : 'Payment Error : ' + response.code.toString());
}

void _handleExternalwallet(ExternalWalletResponse response){
  Fluttertoast.showToast(msg : 'External Payment Success : ' + response.walletName);
}

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Gateway',
           style: TextStyle(
             color: Colors.white,
            ),
          ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
                child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText : 'Enter Amount',
                ),
                onChanged: (value){
                  setState(() {
                    totalAmount = num.parse(value);
                  });
                },
              ),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.black,
              child: Text(
                'Pay',
                style : TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              ),
              onPressed: (){
                opencheckout();
              },
            ),
          ],
        ),
      ),
    );
  }
}