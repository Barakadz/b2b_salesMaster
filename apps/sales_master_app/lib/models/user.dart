import 'package:sales_master_app/models/employee.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String? email;
  String? phone;
  bool isSupervisor;
  List<Employee> employees;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isSupervisor,
    this.email,
    this.phone,
    required this.employees,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final employeesList = (json["employees"] as List<dynamic>)
        .map((item) => Employee.fromJson(item))
        .toList();

    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      employees: employeesList,
      isSupervisor: employeesList.isNotEmpty,
    );
  }
}
