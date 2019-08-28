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
      color: Colors.deepOrange
    ),
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

Widget _buildRoundedButton({String label, Color color, Function onTap}){
  return GestureDetector(
    onTap: onTap,
    child: ClipOval(
      child: Container(
        height: 52.0,
        width: 52.0,
        color: color,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget _showPlayerScoreButtons(Player player) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _buildRoundedButton(
        label: '-1', 
        color: Colors.black.withOpacity(0.1),
        onTap: () {
          setState(() {
           player.score--; 
          });
        },
      ),
     
      _buildRoundedButton(
        label: '+1',
        color: Colors.deepOrangeAccent,
        onTap: () {
          setState(() {
            player.score++;
          });

          if (player.score == 12){
            _showAlertDialog(
              title: 'Fim de Jogo',
              message: 'Deseja jogar outra partida?',
              onCancel: () {
                setState(() {
                 player.score--; 
                });
              }, onConfirm: () {
                setState(() {
                  player.victories++;
                  _resetScoreAll(false);
                });
              }
            );
          }

        },
      ),
    ]
  );
}

Widget _showAppBar() {
  return AppBar(
    title: Text('Marcador de Truco'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: ()(
          _showAlertDialog(
            title: 'Reiniciar',
            message: 'Tem certeza que deseja reiniciar a partida?',
            onConfirm: (){
              _resetScoreAll(true);
            }
          )
        ),
      )
    ],
  );
}


Widget _showBoard() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      _showBoardPlayer(_playerOne),
      _showBoardPlayer(_playerTwo),
    ],
  );
}

Widget _showBoardPlayer(Player player) {
  return Expanded(
    flex: 1,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _showPlayerName(player.name),
      _showPlayerScore(player.score),
      _showPlayerVictories(player.victories),
      _showPlayerScoreButtons(player)
    ],
   ),
  );
}

void _showAlertDialog(
  {String title, String message, Function onCancel, Function onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onCancel();
              }),

            FlatButton(
              child: Text('CONFIRMAR'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onCancel != null) onConfirm();
              }),
          ],
        );
      }
    );
}











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar(),
      body: _showBoard(),
    );
  }
}