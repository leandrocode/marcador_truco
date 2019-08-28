import 'package:flutter/material.dart';
import 'package:marcador_truco/views/home_page.dart';

void main(){
runApp(
  MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.deepOrange
      ),  
      debugShowCheckedModeBanner: false
    )
  );
}

teste integracao vscode