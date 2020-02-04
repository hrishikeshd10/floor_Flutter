import 'dart:async';

import 'package:floor/floor.dart';
import 'package:floor_db_hrishikesh/DAO/StudentDAO.dart';
import 'package:floor_db_hrishikesh/StudentEntity.dart';
 import 'package:path/path.dart';
 import 'package:sqflite/sqflite.dart' as sqflite;   

part 'student_database.g.dart';

@Database(version: 1,entities: [Student])
abstract  class StudentDatabase extends FloorDatabase{
StudentDao get studentDao;
}
