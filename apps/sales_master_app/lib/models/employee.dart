class Employee {
  int id;
  String firstName;
  String lastName;

  Employee({required this.id, required this.firstName, required this.lastName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"]);
  }
}
