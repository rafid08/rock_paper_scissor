import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/controllers/score_controller.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key key, @required this.scoreController}) : super(key: key);
  final ScoreController scoreController;

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  int maxScore = 1;
  int playerScore = 0;
  int computerScore = 0;

  @override
  void initState() {
    widget.scoreController.scorePlayer = (){
      setState(() => playerScore++);

      if(playerScore==maxScore){
        showDialog(context: context, builder: (context)=> dialog(context, true), barrierDismissible: false);
      }
    };
    widget.scoreController.scoreComputer = (){
      setState(() => computerScore++);

      if(computerScore==maxScore){
        showDialog(context: context, builder: (context)=> dialog(context, false), barrierDismissible: false);
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Column(
        children: [
          Expanded(child: IconButton(
            icon: Icon(Icons.refresh, size: 30, color: Colors.grey[400]),
            onPressed: reset,
          )),
          Expanded(
            flex: 2,
            child: Text(
              '$computerScore',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '$playerScore',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialog(BuildContext context, bool won){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You Won!'),
            Text('Score'),
            Text('$playerScore - $computerScore'),
            TextButton(child: Text('Play Again'), onPressed: (){
              Navigator.of(context).pop();
              reset();
            },),
          ],
        ),
      ),
    );
  }

  void reset(){
    setState((){
      playerScore = 0;
      computerScore = 0;
    });
  }
}
