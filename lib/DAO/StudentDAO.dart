import 'package:floor/floor.dart';
import 'package:floor_db_hrishikesh/StudentEntity.dart';

@dao
abstract class StudentDao{
@Query('SELECT * FROM Student')
Stream<List<Student>> getAllStudents();

@insert
  Future<void> insertStudent(Student student);

}