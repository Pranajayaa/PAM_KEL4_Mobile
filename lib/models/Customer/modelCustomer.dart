class ModelCustomer {
  int? id;
  int? personalShopperId;
  String? name;
  String? phone;
  String? email;
  String? status;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  int? updatedBy;

  ModelCustomer(
      {this.id,
        this.personalShopperId,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  ModelCustomer.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
