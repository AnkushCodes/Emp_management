import 'package:EmpManagement/model/data.dart';
import 'package:flutter/material.dart';


class EditData extends StatefulWidget {
  final User data;

  EditData(this.data);

  @override
  _EditDataState createState() => _EditDataState(data);
}

class _EditDataState extends State<EditData> {
  _EditDataState(this.userData);

  User userData;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateCode(String data) {
    if (data == null) return "Should not be empty";
    if (data.length > 8) return "Should not be grater than 8";
    if (data.contains(".")) return "Should not contains decimals";
  }

  validateName(String data) {
    if (data == null) return "Should not be empty";
    if (data.length < 3) return "Should be greater than three";
    if (data.contains(" ")) return "Should not contains space";
  }

  dobValidate(String date){
    if(date == null) return "Please Select Date";
  }

  final Map<String, dynamic> formValues = {"empCode":"", "empName":""};
  List<int> genderValue =[0,1];
  int groupvaleSet;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerCode = TextEditingController();
  DateTime dateVal;
  bool autoVal = false;

  @override
  void initState() {
    super.initState();
    groupvaleSet = userData.getGender();
    textEditingControllerCode.text = userData.empCode.toString();
    textEditingController.text = userData.getDobFormat();
    textEditingControllerName.text = userData.getEmpName();
    dateVal = userData.dob;
  }

  datePicked(BuildContext context)async{
    dateVal = await showDatePicker(context: context,
        initialDate: userData.getDob(),
        firstDate: DateTime.now().subtract(Duration(days: 36500)),
        lastDate: DateTime.now().add(Duration(days: 36500)));
    setState(() {

     if(dateVal != null) textEditingController.text = "${dateVal.day} / ${dateVal.month} / ${dateVal.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit EmpData"),),
      body: Form(
        key: formKey,
        autovalidate: autoVal,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: textEditingControllerCode,
                  validator: (value) => validateCode(value),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => formValues["empCode"] = value,
                  decoration: InputDecoration(
                    hintText: "Emp Code",
                  )
              ),
              TextFormField(
                controller: textEditingControllerName,
                validator: (value) => validateName(value),
                onSaved: (value) => formValues["empName"] = value,
                decoration: InputDecoration(
                  hintText: "Emp Name",
                ),),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0,bottom: 5.0),
                    alignment: Alignment.topLeft,
                    child: Text("Select Gender"),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0.0),
                    title: const Text('Male'),
                    leading: Radio(
                      groupValue: groupvaleSet,
                      value: genderValue[0],
                      onChanged: (val){
                        setState(() {
                          groupvaleSet = val;
                        });

                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0.0),
                    title: const Text('Female'),
                    leading: Radio(
                      groupValue: groupvaleSet,
                      value: genderValue[1],
                      onChanged: (val){
                        setState(() {
                          groupvaleSet = val;
                        });

                      },
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      datePicked(context);
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller:textEditingController ,
                        decoration: InputDecoration(hintText: 'DOB'),
                        maxLength: 15,
                        validator:(value){ return dobValidate(value);},
                      ),

                    ),

                  )
                ],
              ),
              Container(height: 20.0,),
              RaisedButton(
                child: Text('Save'),
                onPressed:(){
                  autoVal = true;
                  if(formKey.currentState.validate()){

                    formKey.currentState.save();
                    userData.setDate(int.parse(formValues["empCode"]),
                        formValues["empName"], groupvaleSet, dateVal,userData.index);
                    userData.addAt(userData.index, userData);
                    Navigator.pop(context);
                  }
                } ,
              )
            ],
          ),
        ),
      ),
    );
  }
}

