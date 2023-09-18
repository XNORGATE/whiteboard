import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});


  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: const Center(
        child: Text('Edit Page'),
      ),
    );
  }
}