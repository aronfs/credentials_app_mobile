import 'package:flutter/material.dart';
class PasswordOptionsCard extends StatelessWidget{
const PasswordOptionsCard({super.key});
Widget tile(String t)=>SwitchListTile(value:true,onChanged:(_){},title:Text(t));
@override Widget build(BuildContext c)=>Card(child:ListView(
children:[tile('Mayúsculas'),Divider(),tile('Minúsculas'),Divider(),tile('Números'),Divider(),tile('Símbolos')]
));}