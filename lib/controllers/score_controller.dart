import 'package:flutter/material.dart';

class ScoreController{
  VoidCallback scorePlayer;
  VoidCallback scoreComputer;

  Function(int playerMove, int computerMove, Result result) updateHand;

  ScoreController();
}

enum Result {win, loose, tie}