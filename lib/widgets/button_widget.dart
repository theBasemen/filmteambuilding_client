import 'package:flutter/material.dart';
import 'package:filmteambuilding_client/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class BasemenButton extends StatelessWidget {
  const BasemenButton(
      {this.icon,
      this.buttonText,
      this.buttonColor,
      this.textColor,
      @required this.onPressedFunc});

  final IconData icon;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Function onPressedFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          basemenComponentsHorizontalMargin,
          basemenComponentsVerticalMargin,
          basemenComponentsHorizontalMargin,
          basemenComponentsVerticalMargin),
      height: basemenComponentsHeight,
      width: double.infinity,
      child: GestureDetector(
        onTap: onPressedFunc,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(child: buttonContent()),
        ),
      ),
    );
  }

  Widget buttonContent() {
    if (icon == null) {
      return Text(
        buttonText,
        style: GoogleFonts.ptSans(
          textStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Row(
        children: [
          SizedBox(width: 20),
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            buttonText,
            style: GoogleFonts.ptSans(
              textStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    }
  }
}
