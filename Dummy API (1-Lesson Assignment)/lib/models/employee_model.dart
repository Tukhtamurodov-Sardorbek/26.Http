class Employee{
  int? id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String? profileImage;

  Employee({
    this.id,
    this.profileImage,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge
  });

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        employeeName = json['employee_name'],
        employeeSalary = json['employee_salary'],
        employeeAge = json['employee_age'],
        profileImage = json['profile_image'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'employee_name' : employeeName,
    'employee_salary' : employeeSalary,
    'employee_age' : employeeAge,
    'profile_image' : profileImage,
  };
}