 import 'package:flutter/material.dart';


 class TabButton extends StatelessWidget {
   final IconData icon;
   final String text;
   final VoidCallback? onPressed;

   TabButton({required this.icon, required this.text, this.onPressed});

   @override
   Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           IconButton(
             icon: Icon(icon, color: Colors.black,),
             onPressed: onPressed,
           ),
           Text(text),
         ],
       ),
     );
   }
 }