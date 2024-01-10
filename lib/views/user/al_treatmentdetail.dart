import 'package:flutter/material.dart';
import 'package:spa_app/data_repository/assign_value.dart';
import 'package:spa_app/models/treatment.dart';

class TreatmentDetail extends StatelessWidget {
  TreatmentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return AlertDialog(
      title: Text("Treatment Detail"),
      content: Stack(
        children: [
          Container(
            height: 600,
            width: 100,
          ),
        ],
      ),
      actions: [okButton],
    );
  }
}
