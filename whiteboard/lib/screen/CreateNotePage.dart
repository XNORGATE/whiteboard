import 'package:flutter/material.dart';
import '../model/model.dart';
class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key, required this.onNoteCreated, });
  final Function(Note) onNoteCreated;

  @override
  // ignore: library_private_types_in_public_api
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: titleController.text.isEmpty ? const Text('New Note'): Text(titleController.text),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 28
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "標題"
              ),
              onChanged: (value) => setState((){}),
            ),
            const SizedBox(height: 10,),
            const Divider(thickness: 1,),
            TextFormField(
              controller: noteController,
              style: const TextStyle(
                fontSize: 18
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "記事"
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(titleController.text.isEmpty | noteController.text.isEmpty){
            return;
          }
          // if(noteController.text.isEmpty){
          //   return;
          // }

          final note = Note(
            body: noteController.text,
            title: titleController.text,
          );

          widget.onNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}


