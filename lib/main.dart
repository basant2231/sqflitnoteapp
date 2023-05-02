import 'package:flutter/material.dart';
import 'package:sqflitnoteapp/addnotes.dart';
import 'package:sqflitnoteapp/edit.dart';
import 'package:sqflitnoteapp/sqflit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SqlDb sqldb = SqlDb();
  List notes = <Map<String, dynamic>>[];
  bool isloading = true;

  readData() async {
    var response = await sqldb.read("notes ");
    notes = response;
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"addnotes": (context) => AddNotes()},
      home: Builder(
        builder: (context) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('addnotes');
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text('homepage'),
          ),
          body: isloading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: notes == null ? 0 : notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(notes[index]['title']),
                      subtitle: Text(notes[index]['note']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                            /*  int response = await sqldb.delete(
                                  '''DELETE FROM notes WHERE id = ${notes[index]['id']}''');*/
                                  int response = await sqldb.delete("notes","id=${notes[index]['id']}");
                              if (response > 0) {
                                List<Map<String, dynamic>> updatedNotes =
                                    List.from(notes);
                                updatedNotes.removeWhere((element) =>
                                    element['id'] == notes[index]['id']);
                                setState(() {
                                  notes = updatedNotes;
                                });
                              }
                            },
                          ),
                          IconButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Editnotes(id: notes[index]['id'], note: notes[index]['note'], title: notes[index]['title'],color:notes[index]['color'] ),));
                          }, icon: Icon(Icons.edit))
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
