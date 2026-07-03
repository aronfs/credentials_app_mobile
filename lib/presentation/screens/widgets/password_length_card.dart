import 'package:flutter/material.dart';
class PasswordLengthCard extends StatelessWidget{
const PasswordLengthCard({super.key});
@override Widget build(BuildContext c)=>Card(child:Padding(
padding:const EdgeInsets.all(16),
child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
Row(children:[Text('Longitud'),Spacer(),Chip(label:Text('16'))]),
Slider(value:16,min:8,max:64,onChanged:(_){})
])));}