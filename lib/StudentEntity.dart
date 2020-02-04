import 'package:floor/floor.dart';

@entity
class Student{
@PrimaryKey(autoGenerate: true)
final int studentID;

final String name;

  Student({this.studentID, this.name});



}