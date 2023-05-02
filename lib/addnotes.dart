import 'package:flutter/material.dart';
import 'package:sqflitnoteapp/main.dart';
import 'package:sqflitnoteapp/sqflit.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: note,
                  decoration: InputDecoration(hintText: 'note'),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'title'),
                ),
                TextFormField(
                  controller: color,
                  decoration: InputDecoration(hintText: 'color'),
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                   /* var response = await sqldb.insertData('''
    INSERT INTO notes (note, title, color)
    VALUES ("${note.text}", "${title.text}", "${color.text}")
  ''');*/
var response = await sqldb.insert('notes', {
  'note':'${note.text}',
  'title':"${color.text}",
  'color':"${color.text}",
}, '');
if (response > 0) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => MyApp(),
    ),
    (route) => false,
  );
}
                  },
                  child: Text('add notes'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
