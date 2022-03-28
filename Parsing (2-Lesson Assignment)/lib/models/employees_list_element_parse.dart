class EmployeeParsing{
  int id;
  String name;
  int salary;
  int age;
  String profileImage;

  EmployeeParsing.fromJson(Map<String, dynamic> json)
      : id = json['id'] is int ? json["id"] : int.parse(json["id"]),
        name = json['employee_name'],
        salary = json['employee_salary'],
        age = json['employee_age'],
        profileImage = json['profile_image'];


  Map<String, dynamic> toJson() => {
    'id' : id,
    'employee_name' : name,
    'employee_salary' : salary,
    'employee_age' : age,
    'profile_image' : profileImage,
  };
}