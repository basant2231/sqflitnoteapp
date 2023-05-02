import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
      }
  }


intialDb() async {
  var databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'wael.db') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 6  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  await db.execute('''
    ALTER TABLE notes ADD COLUMN color TEXT
  ''');
  print("onUpgrade =====================================");
}

_onCreate(Database db , int version) async {
  Batch batch=db.batch();
   batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
   batch.execute('''
  CREATE TABLE "students" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
 await batch.commit();
 print(" onCreate =====================================") ; 

}

read(String table) async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.query(table);
  return response ; 
}
insert(String table, Map<String, Object?> values, String s,) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.insert(table,values);
  return response ; 
}
update(String table, Map<String, dynamic> values, String where) async {
  Database? mydb = await db;
  int response = await mydb!.update(table, values, where: where);
  return response;
}
delete(String table,String where) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.delete(table, where: where);
  return response ; 
}

// SELECT 
// DELETE 
// UPDATE 
// INSERT 
 

}