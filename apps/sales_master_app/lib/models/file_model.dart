class CatalogueFile {
  final int id;
  final String name;
  final double size;
  final String unity;
  final String uploadDate;
  final String uploadedBy;

  CatalogueFile({
    required this.id,
    required this.name,
    required this.size,
    required this.unity,
    required this.uploadDate,
    required this.uploadedBy,
  });

  /// Helper: Convert KB to readable format
  static Map<String, dynamic> formatSize(int sizeInKB) {
    if (sizeInKB >= 1024 * 1024) {
      return {
        "size": (sizeInKB / (1024 * 1024)).toStringAsFixed(2),
        "unit": "GB",
      };
    } else if (sizeInKB >= 1024) {
      return {
        "size": (sizeInKB / 1024).toStringAsFixed(2),
        "unit": "MB",
      };
    } else {
      return {
        "size": sizeInKB.toString(),
        "unit": "KB",
      };
    }
  }

  factory CatalogueFile.fromJson(Map<String, dynamic> json) {
    final formatted = formatSize(json["size"] ?? 0);

    return CatalogueFile(
      id: json["id"],
      name: json["title"] ?? "",
      size: double.tryParse(formatted["size"]) ?? 0,
      unity: formatted["unit"],
      uploadDate: json["uploaded_at"] ?? "",
      uploadedBy:
          "${json["uploaded_by"]?["first_name"] ?? ""} ${json["uploaded_by"]?["last_name"] ?? ""}"
              .trim(),
    );
  }
}
