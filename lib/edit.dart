import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sqflitnoteapp/main.dart';
import 'package:sqflitnoteapp/sqflit.dart';

class Editnotes extends StatefulWidget {
  const Editnotes(
      {super.key,
      required this.id,
      required this.note,
      required this.title,
      this.color});
  final note;
  final title;
  final id;
  final color;

  @override
  State<Editnotes> createState() => _EditnotesState();
}

class _EditnotesState extends State<Editnotes> {
  @override
  SqlDb sqldb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

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
                    /*  var response = await sqldb.updateData('''
   UPDATE notes SET note='${note.text}',title='${title.text}',color='${color.text}' WHERE id =${widget.id.text}
  ''');*/
                    int response = await sqldb.insert(
                        "notes",
                        {
                          "note": '${note.text}',
                          "title": '${title.text}',
                          "color": '${color.text}'
                        },
                        "id =${widget.id.text}");
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Text('edit notes'),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
