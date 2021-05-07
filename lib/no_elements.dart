import 'package:flutter/material.dart';

class NoElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[200],
        border: Border.all(
          color: Colors.grey,
          width: 5,
        ),
      ),
      // color: Colors.indigo[100],
      height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(50),
      child: Text(
        'Having a Busy Schedule?\n Add Some Tasks.',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Voltaire',
          fontSize: 24,
        ),
      ),
    );
  }
}
