import 'package:sales_master_app/models/employee.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String? email;
  String? phone;
  bool isSupervisor;
  List<Employee> employees;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.isSupervisor,
      this.email,
      this.phone,
      required this.employees});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        employees:
            json["employee"].map((item) => Employee.fromJson(item)).toList(),
        isSupervisor: json["employee"].length > 0);
  }
}
