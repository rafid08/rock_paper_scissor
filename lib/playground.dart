import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/controllers/score_controller.dart';

import 'components/buttons.dart';
import 'components/hands.dart';
import 'components/scoreboard.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({Key key}) : super(key: key);

  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  ScoreController scoreController = ScoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 7, child: Row(
            children: [
              Expanded(child: Hands(scoreController: scoreController,)),
              ScoreBoard(scoreController:scoreController,),
            ],
          )),
          Expanded(child: Buttons(scoreController: scoreController,)),
        ],
      ),
    );
  }
}
