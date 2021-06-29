import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/controllers/score_controller.dart';

List images = ['assets/rock.png', 'assets/paper.png', 'assets/scissor.png'];

class Hands extends StatefulWidget {
  const Hands({Key key, @required this.scoreController}) : super(key: key);
  final ScoreController scoreController;

  @override
  _HandsState createState() => _HandsState();
}

class _HandsState extends State<Hands> {
  double playerPadding = 20;
  double computerPadding = 20;
  Duration duration = Duration(milliseconds: 500);

  String playerImage = images[1];
  String computerImage = images[1];

  @override
  void initState() {
    widget.scoreController.updateHand = updateHand;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Expanded(
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(computerPadding),
              child: Transform.rotate(angle: pi, child: Image.asset(computerImage)),
            ),
          ),
          Expanded(
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(playerPadding),
              child: Image.asset(playerImage),
            ),
          ),
        ],
      ),
    );
  }

  void updateHand(int playerMove, int computerMove, Result result) async {
    await runPlayerAnimation(playerMove, computerMove);

    if(result==Result.loose){
      setState(() => computerPadding = 5);
      Future.delayed(duration).then((value) => setState(() => computerPadding = 20));
    } else if(result==Result.win){
      setState(() => playerPadding = 5);
      Future.delayed(duration).then((value) => setState(() => playerPadding = 20));
    } else if(result==Result.tie){
      setState((){
        playerPadding = 10;
        computerPadding = 10;
      });
      Future.delayed(duration).then((value) => setState((){
        playerPadding = 20;
        computerPadding = 20;
      }));
    }
  }

  Future runPlayerAnimation(int playerMove, int computerMove) async{
    for(int i=0; i<10; i++){
      setState(() => playerImage=images[i%3]);
      setState(() => computerImage=images[(i+2)%3]);
      await Future.delayed(Duration(milliseconds: 50));
    }
    setState(() => playerImage=images[playerMove]);
    setState(() => computerImage=images[computerMove]);
  }
}
