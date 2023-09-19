import 'package:flutter/material.dart';
import '../model/model.dart';

class NoteView extends StatefulWidget {
  NoteView(
      {super.key,
      required this.note,
      required this.index,
      required this.onNoteDeleted,
      required this.onNoteUpdated});

  late Note note;
  final int index;

  final Function(int) onNoteDeleted;
  final Function(int, Note) onNoteUpdated;

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  // GlobalKey<MyHomePageState> noteCreateKey = GlobalKey<MyHomePageState>();
  bool isEditing = false;
  late TextEditingController titleEditController;
  late TextEditingController noteEditController;
  @override
  void initState() {
    super.initState();
    titleEditController = TextEditingController(text: widget.note.title);
    noteEditController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    var note = widget.note;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(note.title),
          actions: [
            IconButton(
              onPressed: () {
                isEditing = true;

                setState(() {});
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("確定要刪除 ?"),
                        content: Text("即將刪除 ${note.title} 筆記!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.onNoteDeleted(widget.index);
                              Navigator.of(context).pop();
                            },
                            child: const Text("刪除"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("取消"),
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: isEditing
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleEditController,
                      style: const TextStyle(fontSize: 28),
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "標題"),
                      onChanged: (value) => setState(() {
                        // titleEditController.text = value;
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    TextFormField(
                      controller: noteEditController,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "記事"),
                      // onChanged: (value) => setState(() {
                      // }),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      note.body,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
        floatingActionButton: isEditing
            ? FloatingActionButton(
                onPressed: () {
                  print(widget.index);
                  if (titleEditController.text.isEmpty |
                      noteEditController.text.isEmpty) {
                    return;
                  }
                  // if(noteController.text.isEmpty){
                  //   return;
                  // }

                  var note = Note(
                    body: noteEditController.text,
                    title: titleEditController.text,
                  );

                  // myHomePageState.notes.add(note);

                  isEditing = false;

                  setState(() {
                    widget.onNoteUpdated(widget.index, note);
                    widget.note = note;
                  });
                },
                child: const Icon(Icons.save),
              )
            : null);
  }
}
