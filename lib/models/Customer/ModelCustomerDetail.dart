class ModelCustomerDetail {
  List<Results>? results;

  ModelCustomerDetail({this.results});

  ModelCustomerDetail.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? personalShopperId;
  String? name;
  String? phone;
  String? email;
  String? status;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  Null? updatedBy;
  Personalshopper? personalshopper;

  Results(
      {this.id,
        this.personalShopperId,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.personalshopper});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalShopperId = json['personal_shopper_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    personalshopper = json['personalshopper'] != null
        ? new Personalshopper.fromJson(json['personalshopper'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['personal_shopper_id'] = this.personalShopperId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    if (this.personalshopper != null) {
      data['personalshopper'] = this.personalshopper!.toJson();
    }
    return data;
  }
}

class Personalshopper {
  int? id;
  int? categoryId;
  String? providerName;
  String? name;
  String? description;
  int? stock;
  int? temporaryStock;
  int? status;
  String? waAdmin;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  Null? updatedBy;

  Personalshopper(
      {this.id,
        this.categoryId,
        this.providerName,
        this.name,
        this.description,
        this.stock,
        this.temporaryStock,
        this.status,
        this.waAdmin,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  Personalshopper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    providerName = json['provider_name'];
    name = json['name'];
    description = json['description'];
    stock = json['stock'];
    temporaryStock = json['temporary_stock'];
    status = json['status'];
    waAdmin = json['wa_admin'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['provider_name'] = this.providerName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['temporary_stock'] = this.temporaryStock;
    data['status'] = this.status;
    data['wa_admin'] = this.waAdmin;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
