

class EmpUsers
{
  static List<User> userData=[];
}

class User {
  int empCode;
  String empName;
  int gender;
  DateTime dob;
  int index;

  static int pointer = 0;

  setDate(int empCode,String empName,int gender,DateTime dob,int index){
    this.empCode = empCode;
    this.empName = empName;
    this.gender  = gender;
    this.dob     = dob;
    this.index   = index;
  }

  addEmpData(int empCode,String empName,int gender,DateTime dob){
    this.empCode = empCode;
    this.empName = empName;
    this.gender  = gender;
    this.dob     = dob;
    this.index   = pointer++;

  }

  empAdd(User user){

    EmpUsers.userData.add(user);
    return EmpUsers.userData;
  }

  removeEmp(int atData){
    EmpUsers.userData.removeAt(atData);
    int val =0;
    EmpUsers.userData.forEach((userIndex){
      userIndex.index = val++;
    });
    pointer = EmpUsers.userData.length;
  }

  addAt(int atData, User user){
    EmpUsers.userData[atData] = user;
  }

  String getEmpCode(){
    return empCode.toString();
  }

  String getEmpName(){
   return empName;
  }

  int getGender(){
    return gender;
  }

  getDobFormat(){
      return "${dob.day} / ${dob.month} / ${dob.year}";
  }

  getDob(){
    return dob;
  }

  isDatSet(){
    if(empName!=null && empCode!=null && gender!=null && dob != null){
      return true;
    }else{
      return false;
    }
  }



}

class EmpData {
  static User user = User();
}
