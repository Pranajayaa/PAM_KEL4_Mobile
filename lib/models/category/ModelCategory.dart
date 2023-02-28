class ModelCategory {
  int? id;
  String? name;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  int? updatedBy;

  ModelCategory(
      {this.id,
        this.name,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  ModelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
