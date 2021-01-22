import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200),
          Container(
            width: 140,
            child: Image.asset('assets/filmteambuildingLogo.png'),
          ),
          SizedBox(height: 30),
          Container(
              width: 300,
              child: Image.asset('assets/filmteambuildingText.png')),
        ],
      ),
    );
  }
}
