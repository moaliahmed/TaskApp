import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContainerSound extends StatelessWidget {
  const ContainerSound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      child: Row(
        children: [Icon(Icons.play_arrow_rounded),
        Text('Sound Playing')
        ],
      ),
    );
  }
}