import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/controllers/score_controller.dart';

import 'hands.dart';

class Buttons extends StatefulWidget {
  const Buttons({Key key, @required this.scoreController}) : super(key: key);
  final ScoreController scoreController;

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  int playerMove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        button(id: 0),
        button(id: 1),
        button(id: 2),
      ],
    );
  }
  
  Widget button({@required int id}){

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: ()=>handleClick(id),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(images[id]),
        ),
        style: ButtonStyle(
          backgroundColor: playerMove==null ?
            MaterialStateProperty.all(Colors.green[100])
            : playerMove==id ? MaterialStateProperty.all(Colors.green[300])
            : MaterialStateProperty.all(Colors.green[50]),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
        ),
      ),
    );
  }

  handleClick(int id) async{
    if(playerMove==null){
      setState(() => playerMove = id);
      generateResult(id);
      await Future.delayed(Duration(seconds: 1));
      setState(() => playerMove = null);
    }
  }

  generateResult(int playerMove){
    Result result;
    int computerMove = Random().nextInt(2);

    if(playerMove==computerMove) result = Result.tie;
    else if(playerMove==0 && computerMove==1) result = Result.loose;
    else if(playerMove==0 && computerMove==2) result = Result.win;
    else if(playerMove==1 && computerMove==0) result = Result.win;
    else if(playerMove==1 && computerMove==2) result = Result.loose;
    else if(playerMove==2 && computerMove==0) result = Result.loose;
    else if(playerMove==2 && computerMove==1) result = Result.win;

    if(result==Result.win) widget.scoreController.scorePlayer();
    else if(result==Result.loose) widget.scoreController.scoreComputer();

    widget.scoreController.updateHand(playerMove, computerMove, result);
  }
}
