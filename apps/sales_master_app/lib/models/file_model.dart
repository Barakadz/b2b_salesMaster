class UploadedFile {
  int id;
  String name;
  double size;
  String uploadDate;
  String uploadedBy;
  String unity;

  UploadedFile(
      {required this.id,
      required this.name,
      required this.size,
      required this.uploadDate,
      required this.unity,
      required this.uploadedBy});

  factory UploadedFile.fromJson(Map<String, dynamic> json) {
    return UploadedFile(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        unity: json["unity"],
        uploadDate: json["uploadDate"],
        uploadedBy: json["uploadedBy"]);
  }
}
