import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Screen"),
      ),
      body: Center(
        child: Text(
          "Hello, World!",
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
    );
  }
}
