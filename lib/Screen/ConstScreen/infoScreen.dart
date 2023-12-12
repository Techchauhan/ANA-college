import 'package:ana/Const/Colors.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
        backgroundColor: AppColors.defaultColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/pulsezestIntro.png'),
            const Text(
              "PulseZest",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "🌟 About PulseZest:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "At PulseZest, we believe in the power of creativity and self-expression. Our collage application is designed to inspire and empower you to turn your memories into beautiful works of art. Whether you're commemorating a special occasion or simply celebrating life's everyday moments, PulseZest is here to help you create stunning collages that capture the essence of your experiences.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "🚀 Features:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                " 1. Intuitive Interface: Our user-friendly interface ensures a seamless collage creation process, allowing you to focus on expressing yourself without any hassle.\n  2. Versatile Templates: Choose from a diverse range of templates that cater to various themes and styles. From vibrant celebrations to serene landscapes, we have the perfect template for every occasion. \n 3. Customization Options: Personalize your collages with a variety of customization options. Add text, stickers, filters, and more to make your creations truly unique.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 10,width: 10,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "🌐 Connect with Us:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Website: www.pulsezest.com \n Support: Reach out to us at support@pulsezest.com for any assistance or inquiries. Our dedicated support team is here to help you make the most of your collage creation experience.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
