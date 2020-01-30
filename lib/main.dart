import 'package:flutter/material.dart';
import 'listwidget.dart';
import 'model/data.dart';
import 'screens/addEmp.dart';
import 'screens/editData.dart';


void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              {
                return MaterialPageRoute(builder: (context) => Home());
              }

            case '/editEmp':
              {
                return MaterialPageRoute(
                    builder: (context) => EditData(settings.arguments));
              }
            case '/addEmp':
              {
                return MaterialPageRoute(
                    builder: (context) => AddEmpData());
              }
          }
          return null;
        });
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User userData = EmpData.user;

  @override
  void initState() {
    super.initState();
    setWidgets();
  }
  List<Widget> childWidgetSet=[];

  changeValue(){
    setState(() {
      setWidgets();
    });
  }

  setWidgets(){
    childWidgetSet=[];
    EmpUsers.userData.length>0?
    EmpUsers.userData.forEach((values){
      childWidgetSet.add(TileWidegetStore(values,changeValue));
    }):[];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnkushTest EmpMangement'),
      ),
      body: !(childWidgetSet.length>0)
          ? Center(
              child: Text('Empty Here Add Data'),
            )
          : Container(
              margin: EdgeInsets.all(10.0),
              child: ListView(
                children: childWidgetSet
              ),
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          Navigator.pushNamed(context, '/addEmp').then((value){
            changeValue();

          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
