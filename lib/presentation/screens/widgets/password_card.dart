import 'package:flutter/material.dart';
class PasswordCard extends StatelessWidget{
const PasswordCard({super.key});

@override Widget build(BuildContext c)=>Card(child:Padding(
padding:const EdgeInsets.all(16),
child:Column(children:[
Row(children:[Chip(label:Text('MUY FUERTE')),Spacer(),Icon(Icons.refresh),SizedBox(width:8),Icon(Icons.copy)]),
SizedBox(height:24),
SelectableText(r'aX8$mK#9vLq2!pZ',textAlign:TextAlign.center,style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
SizedBox(height:24),
LinearProgressIndicator(value:.9)
]))); }