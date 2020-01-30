import 'package:AnkushTest/model/data.dart';
import 'package:flutter/material.dart';

class AddEmpData extends StatefulWidget {
  @override
  _AddEmpDataState createState() => _AddEmpDataState();
}

class _AddEmpDataState extends State<AddEmpData> {
  User userData;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateCode(String data) {
    if (data == null) return "Should not be empty";
    if (data.length > 8) return "Should not be grater than 8";
    if (data.length < 1) return "Should be grater than 1";
    if (data.contains(".")) return "Should not contains decimals";
  }

  validateName(String data) {
    if (data == null) return "Should not be empty";
    if (data.length < 3) return "Should be greater than three";
    if (data.contains(" ")) return "Should not contains space";
  }

  dobValidate(String value) {
    if (dateVal == null) return "Please Select Date";
  }

  final Map<String, String> formValues = {"empCode": "", "empName": ""};
  List<int> genderValue = [0, 1];
  int groupvaleSet;
  TextEditingController textEditingController = TextEditingController();
  DateTime dateVal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupvaleSet = genderValue[0];
  }

  datePicked(BuildContext context) async {
    dateVal = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 36500)),
        lastDate: DateTime.now().add(Duration(days: 36500)));
    setState(() {
      if (dateVal != null)
        textEditingController.text =
            "${dateVal.day} / ${dateVal.month} / ${dateVal.year}";
    });
  }

  bool autoVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Emp Details'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          autovalidate: autoVal,
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                    validator: (value) => validateCode(value),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => formValues["empCode"] = value,
                    decoration: InputDecoration(
                      hintText: "Emp Code",
                    )),
                TextFormField(
                  validator: (value) => validateName(value),
                  onSaved: (value) => formValues["empName"] = value,
                  decoration: InputDecoration(
                    hintText: "Emp Name",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
                  alignment: Alignment.topLeft,
                  child: Text("Select Gender"),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0.0),
                  title: const Text('Male'),
                  leading: Radio(
                    groupValue: groupvaleSet,
                    value: genderValue[0],
                    onChanged: (val) {
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
                    onChanged: (val) {
                      setState(() {
                        groupvaleSet = val;
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    datePicked(context);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(hintText: 'DOB'),
                      maxLength: 15,
                      validator: (String value) {
                        return dobValidate(value);
                      },
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    setState(() {
                      autoVal = true;
                    });
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      User userVal = User();
                      userVal.addEmpData(int.parse(formValues["empCode"]),
                          formValues["empName"], groupvaleSet, dateVal);
                      userVal.empAdd(userVal);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
