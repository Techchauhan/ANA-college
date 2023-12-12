import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class StudentPaymentScreen extends StatefulWidget {
  @override
  _StudentPaymentScreenState createState() => _StudentPaymentScreenState();
}

class _StudentPaymentScreenState extends State<StudentPaymentScreen> {
  Razorpay _razorpay = Razorpay();

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Dispose of the Razorpay object
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Fee Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the amount to pay',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter the amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                if (amount > 0) {
                  _startPayment(amount);
                } else {
                  _showInvalidAmountDialog();
                }
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _startPayment(double amount) async {
    // Replace 'YOUR_KEY_ID' with your Razorpay key ID
    String keyId = 'rzp_live_ImOnQ3F8ERnWhL';

    var options = {
      'key': keyId,
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'ANA Collage',
      'description': 'Payment for college fees',
      'prefill': {
        'contact': 'YOUR_CONTACT_NUMBER',
        'email': 'YOUR_EMAIL_ADDRESS',
      },
      'currency': 'INR',
      'theme.color': '#009688', // Set your theme color
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error during payment: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment success logic
    _showPaymentSuccessDialog(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment error logic
    _showPaymentErrorDialog(response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // External wallet logic
    debugPrint('External Wallet: ${response.walletName}');
  }

  void _showPaymentSuccessDialog(String paymentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Payment successful. Payment ID: $paymentId'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Error'),
          content: Text('Payment failed. Error: $errorMessage'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showInvalidAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Amount'),
          content: Text('Please enter a valid amount to proceed with the payment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


