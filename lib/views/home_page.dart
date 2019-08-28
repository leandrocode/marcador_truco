import 'package:flutter/material.dart';
import 'package:marcador_truco/models/player.dart';

class HomePage extends StatefulWidget {
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _playerOne = Player(name: 'Nós', score: 0, victories: 0);
  var _playerTwo = Player(name: 'Eles', score: 0, victories: 0);

  void _resetScore(Player player, bool resetVictories){
    setState(() {
      player.score = 0;
      player.victories = resetVictories ? 0 : player.victories;
    });
  }

  void _resetScoreAll(bool resetVictories){
    _resetScore(_playerOne, resetVictories);
    _resetScore(_playerTwo, resetVictories);
  }

@override
void initState(){
  super.initState();
  _resetScoreAll(true);
} 

Widget _showPlayerName(String name){
  return Text(
    name.toUpperCase(),
    style:TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: Colors.deepOrange),
  );
}

Widget _showPlayerVictories(int victories){
  return Text(
    'vitórias ( $victories )',
    style:TextStyle(fontWeight: FontWeight.w300),
  );
}

Widget _showPlayerScore(int score){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 52.0),
    child: Text(
      '$score',
      style: TextStyle(fontSize: 120.0),
    )
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}