class ModelJastip {
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
  int? updatedBy;
  List<PersonalShopperImages>? personalShopperImages;

  ModelJastip(
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
        this.updatedBy,
        this.personalShopperImages});

  ModelJastip.fromJson(Map<String, dynamic> json) {
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
    if (json['personal_shopper_images'] != null) {
      personalShopperImages = <PersonalShopperImages>[];
      json['personal_shopper_images'].forEach((v) {
        personalShopperImages!.add(new PersonalShopperImages.fromJson(v));
      });
    }
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
    if (this.personalShopperImages != null) {
      data['personal_shopper_images'] =
          this.personalShopperImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonalShopperImages {
  int? id;
  int? personalShopperId;
  String? name;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  int? updatedBy;

  PersonalShopperImages(
      {this.id,
        this.personalShopperId,
        this.name,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  PersonalShopperImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalShopperId = json['personal_shopper_id'];
    name = json['name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['personal_shopper_id'] = this.personalShopperId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
