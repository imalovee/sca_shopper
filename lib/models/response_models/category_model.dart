

class CategoryModel {
    final int? id;
    final String? name;
    final String? image;
    final DateTime? creationAt;
    final DateTime? updatedAt;

    CategoryModel({
        this.id,
        this.name,
        this.image,
        this.creationAt,
        this.updatedAt,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
