class WalletAdminModel {
  String? id;
  String? type;
  String? status;
  String? amount;
  String? proofLink;
  String? method;
  String? accountName;
  String? accountNumber;
    String? bankName;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  User? user;

  WalletAdminModel(
      {this.id,
      this.type,
      this.status,
      this.amount,
      this.proofLink,
      this.method,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.user});

  WalletAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    amount = json['amount'];
    proofLink = json['proofLink'];
    method = json['method'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['proofLink'] = this.proofLink;
    data['method'] = this.method;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? password;
  bool? isVerified;
  int? verifiedCode;
  Null? resetPasswordToken;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  User(
      {this.id,
      this.email,
      this.password,
      this.isVerified,
      this.verifiedCode,
      this.resetPasswordToken,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    isVerified = json['is_verified'];
    verifiedCode = json['verified_code'];
    resetPasswordToken = json['reset_password_token'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_verified'] = this.isVerified;
    data['verified_code'] = this.verifiedCode;
    data['reset_password_token'] = this.resetPasswordToken;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}