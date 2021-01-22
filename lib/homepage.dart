import 'package:flutter/material.dart';
import 'widgets/logo_widget.dart';
import 'widgets/button_widget.dart';
import 'constants.dart';
import 'source_page.dart';
import 'widgets/dropdown_widget.dart';

String selectedTeam = 'Team A';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              LogoWidget(),
              Column(
                children: [
                  SizedBox(height: 30),
                  BuildDropdown(
                    itemsList: ['Team A', 'Team B', 'Team C', 'Team D'],
                    defaultValue: 'Team A',
                    dropdownHint: 'Select Required Option',
                    onChanged: (value) {
                      selectedTeam = value;
                      print(selectedTeam);
                    },
                  ),
                  BasemenButton(
                    onPressedFunc: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SourcePage(),
                        settings: RouteSettings(arguments: selectedTeam),
                      ));
                    },
                    buttonText: 'Upload video clips',
                    buttonColor: vtfOrange,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                  child:
                      Text('All rights reserved - 2021 filmteambuilding.dk'))),
        ],
      ),
    );
  }
}
