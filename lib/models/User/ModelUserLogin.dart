class UserLogin {
  Data? data;
  bool? success;
  int? code;

  UserLogin({this.data, this.success, this.code});

  UserLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? id;
  int? roleId;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? picture;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.roleId,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.picture,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
