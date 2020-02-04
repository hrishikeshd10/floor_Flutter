import 'package:floor_db_hrishikesh/DAO/StudentDAO.dart';
import 'package:floor_db_hrishikesh/Database/student_database.dart';
import 'package:floor_db_hrishikesh/StudentEntity.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final _snackKey = GlobalKey<ScaffoldState>();

class _HomeState extends State<Home> {
 
 StudentDatabase studentDatabase;
 StudentDao studentDao;

// builder() async{
//     studentDatabase = await $FloorStudentDatabase.databaseBuilder('student.db').build();
    
// }

builder()async{
  studentDatabase = await $FloorStudentDatabase.databaseBuilder('student.db').build();
  setState(() {
      
  studentDao = studentDatabase.studentDao;
  });
}

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

builder();



  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder(
      stream: studentDao.getAllStudents(),
      builder: (context,AsyncSnapshot<List<Student>> snapshot){
        if(!snapshot.hasData) Container();

    final studentList = snapshot.data;
    return ListView.builder(
      itemCount: studentList.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.add_a_photo),
          title: Text('${studentList[index].name}'),
        );
      });

      }),


floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
  onPressed: ()async{
  String patientName = await _asyncInputDialog(context);
          var patient = Student(name: patientName);
          await studentDao.insertStudent(patient);
  },
),


    );
  }




  Future<String> _asyncInputDialog(BuildContext context) async {
    String patientName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Name'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: new InputDecoration(
                    labelText: 'Patient Name', hintText: 'eg. Harshal Pathak'),
                onChanged: (value) {
                  patientName = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Add'),
              onPressed: () {
              //  _snackKey.currentState.removeCurrentSnackBar();
                if (patientName.isNotEmpty) {
                  Navigator.of(context).pop(patientName);
                } else {
                  _snackKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Please Enter Patient Name'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

